package com.epam.learnmodulith.stock.internal.job

import com.epam.learnmodulith.stock.internal.model.StockOrderStatus
import com.epam.learnmodulith.stock.internal.repository.StockOrderRepository
import com.epam.learnmodulith.stock.internal.service.StockOrderService
import org.slf4j.LoggerFactory
import org.springframework.scheduling.annotation.Scheduled
import org.springframework.stereotype.Component
import org.springframework.transaction.annotation.Transactional

/**
 * Scheduled job that runs every 5 minutes.
 * Finds OPEN stock-orders, generates an order file for each, and sets status to PENDING.
 */
@Component
class OrderingJob(
    private val stockOrderRepository: StockOrderRepository,
    private val stockOrderService: StockOrderService
) {
    private val logger = LoggerFactory.getLogger(OrderingJob::class.java)

    @Scheduled(fixedDelay = 5 * 60 * 1000) // 5 minutes
    @Transactional
    fun processOpenOrders() {
        val openOrders = stockOrderRepository.findByStatusOrderByCreatedAtAscForUpdate(StockOrderStatus.OPEN)
        if (openOrders.isEmpty()) return
        logger.debug("Processing ${openOrders.size} open stock-order(s)")
        openOrders.forEach { order ->
            try {
                stockOrderService.processOrderingForOrder(order)
            } catch (e: Exception) {
                logger.error("Failed to process ordering for stock-order ${order.id}", e)
            }
        }
    }
}
