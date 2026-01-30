package com.epam.learnmodulith.stock.internal.listener

import com.epam.learnmodulith.product.api.ProductsStockLowEvent
import com.epam.learnmodulith.stock.internal.service.StockOrderService
import org.slf4j.LoggerFactory
import org.springframework.modulith.events.ApplicationModuleListener
import org.springframework.scheduling.annotation.Async
import org.springframework.stereotype.Component

/**
 * Listener for ProductsStockLowEvent.
 * Runs on a single-thread executor so all batch events are processed one after another.
 * Finds or creates an OPEN stock-order and merges all product quantities into it.
 */
@Component
class ProductStockLowEventListener(
    private val stockOrderService: StockOrderService
) {
    private val logger = LoggerFactory.getLogger(ProductStockLowEventListener::class.java)

    @ApplicationModuleListener
    @Async("stockOrderEventExecutor")
    fun handleProductsStockLow(event: ProductsStockLowEvent) {
        if (event.productQuantities.isEmpty()) return
        logger.info("Handling low stock batch: ${event.productQuantities.size} product(s)")
        stockOrderService.addOrUpdateOpenOrderBatch(productQuantities = event.productQuantities)
    }
}
