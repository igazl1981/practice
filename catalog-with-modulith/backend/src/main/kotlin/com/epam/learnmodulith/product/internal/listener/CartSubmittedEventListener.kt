package com.epam.learnmodulith.product.internal.listener

import com.epam.learnmodulith.cart.api.CartSubmittedEvent
import com.epam.learnmodulith.product.internal.service.ProductService
import org.slf4j.LoggerFactory
import org.springframework.modulith.events.ApplicationModuleListener
import org.springframework.stereotype.Component

/**
 * Listener for cart submission events.
 * Deducts product stock when a cart is submitted.
 */
@Component
class CartSubmittedEventListener(
    private val productService: ProductService
) {
    private val logger = LoggerFactory.getLogger(CartSubmittedEventListener::class.java)

    @ApplicationModuleListener
    fun handleCartSubmitted(event: CartSubmittedEvent) {
        logger.info("Handling cart submission event for cart ID: ${event.cartId}")
        try {
            productService.deductStock(event.productQuantities)
            logger.info("Successfully deducted stock for ${event.productQuantities.size} products")
        } catch (e: Exception) {
            logger.error("Error deducting stock for cart ${event.cartId}", e)
            throw e
        }
    }
}
