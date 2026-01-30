package com.epam.learnmodulith.stock.internal.job

import com.epam.learnmodulith.stock.internal.model.StockOrderStatus
import com.epam.learnmodulith.stock.internal.repository.StockOrderRepository
import com.epam.learnmodulith.stock.internal.service.StockOrderService
import org.slf4j.LoggerFactory
import org.springframework.scheduling.annotation.Scheduled
import org.springframework.stereotype.Component
import java.time.LocalDateTime

/**
 * Scheduled job that runs every 5 minutes.
 * Finds PENDING stock-orders older than 10 minutes, adds stock via ProductApi, and sets status to CLOSED.
 */
@Component
class StockReloadJob(
    private val stockOrderRepository: StockOrderRepository,
    private val stockOrderService: StockOrderService
) {
    private val logger = LoggerFactory.getLogger(StockReloadJob::class.java)

    @Scheduled(fixedDelay = 5 * 60 * 1000) // 5 minutes
    fun processPendingOrders() {
        val threshold = LocalDateTime.now().minusMinutes(10)
        val pendingOrders = stockOrderRepository.findByStatusAndCreatedAtBefore(
            StockOrderStatus.PENDING,
            threshold
        )
        if (pendingOrders.isEmpty()) return
        logger.debug("Processing ${pendingOrders.size} pending stock-order(s) older than 10 minutes")
        pendingOrders.forEach { order ->
            try {
                stockOrderService.processReloadForOrder(order)
            } catch (e: Exception) {
                logger.error("Failed to reload stock for stock-order ${order.id}", e)
            }
        }
    }
}
