package com.epam.learnmodulith.stock.internal.service

import com.epam.learnmodulith.product.api.ProductApi
import com.epam.learnmodulith.stock.internal.config.StockOrderProperties
import com.epam.learnmodulith.stock.internal.model.StockOrder
import com.epam.learnmodulith.stock.internal.model.StockOrderStatus
import com.epam.learnmodulith.stock.internal.repository.StockOrderRepository
import org.slf4j.LoggerFactory
import org.springframework.data.domain.PageRequest
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional
import java.nio.file.Files
import java.time.LocalDateTime
import java.time.format.DateTimeFormatter

@Service
class StockOrderService(
    private val stockOrderRepository: StockOrderRepository,
    private val productApi: ProductApi,
    private val properties: StockOrderProperties
) {
    private val logger = LoggerFactory.getLogger(StockOrderService::class.java)

    /**
     * Finds or creates the latest OPEN stock-order, then merges all product quantities into it.
     * @param productQuantities product ID -> quantity to order (positive, amount under zero)
     */
    @Transactional
    fun addOrUpdateOpenOrderBatch(productQuantities: Map<Long, Int>) {
        if (productQuantities.isEmpty()) return
        val openOrder = stockOrderRepository
            .findTopByStatusOrderByCreatedAtDescForUpdateSkipLocked(
                StockOrderStatus.OPEN,
                PageRequest.of(0, 1)
            )
            .firstOrNull()
            ?: stockOrderRepository.save(
                StockOrder(status = StockOrderStatus.OPEN, products = mutableMapOf())
            )
        productQuantities.forEach { (productId, qty) ->
            openOrder.products.merge(productId.toString(), qty, Int::plus)
        }
        stockOrderRepository.save(openOrder)
        logger.debug("Updated open stock-order ${openOrder.id} with ${productQuantities.size} product(s)")
    }

    /**
     * For a given OPEN order: computes quantities with extra (extra = missing / extraDivisor),
     * writes the order file, then updates the order to PENDING with the new quantities.
     * If file write fails, the order is not updated.
     */
    @Transactional
    fun processOrderingForOrder(order: StockOrder): Boolean {
        if (order.status != StockOrderStatus.OPEN || order.products.isEmpty()) return false
        val divisor = properties.extraDivisor.coerceAtLeast(1)
        val newProducts = order.products.mapValues { (_, missing) ->
            val extra = missing / divisor
            missing + extra
        }.toMutableMap()
        val productIds = newProducts.keys.map { it.toLong() }
        val productInfos = productApi.findByIds(productIds).associateBy { it.id }
        val lines = mutableListOf<String>()
        lines.add("Order ID: ${order.id}")
        lines.add("Date and Time: ${LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"))}")
        lines.add("")
        lines.add("Products to order:")
        newProducts.forEach { (idStr, qty) ->
            val name = productInfos[idStr.toLong()]?.name ?: "Product $idStr"
            lines.add("  $name, quantity: $qty")
        }
        val fileName = "stock-order-${order.id!!}-${LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMdd-HHmm"))}.txt"
        val outputPath = properties.outputPath.resolve(fileName)
        try {
            Files.createDirectories(properties.outputPath)
            Files.writeString(outputPath, lines.joinToString(System.lineSeparator()))
        } catch (e: Exception) {
            logger.error("Failed to write order file for stock-order ${order.id}", e)
            return false
        }
        order.products = newProducts
        order.status = StockOrderStatus.PENDING
        stockOrderRepository.save(order)
        logger.info("Stock-order ${order.id} processed: file written, status set to PENDING")
        return true
    }

    /**
     * For a PENDING order: adds each product's quantity to stock via ProductApi, then sets order to CLOSED.
     */
    @Transactional
    fun processReloadForOrder(order: StockOrder) {
        if (order.status != StockOrderStatus.PENDING) return
        order.products.forEach { (productIdStr, quantity) ->
            try {
                productApi.addStock(productIdStr.toLong(), quantity)
            } catch (e: Exception) {
                logger.error("Failed to add stock for product $productIdStr in order ${order.id}", e)
                throw e
            }
        }
        order.status = StockOrderStatus.CLOSED
        stockOrderRepository.save(order)
        logger.info("Stock-order ${order.id} reloaded and closed")
    }
}
