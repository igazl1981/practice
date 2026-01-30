package com.epam.learnmodulith.cart.api

/**
 * Event published when a cart is successfully submitted.
 * Contains product IDs and their quantities for tracking sold amounts.
 */
data class CartSubmittedEvent(
    val cartId: Long,
    val productQuantities: Map<Long, Int> // productId -> quantity
)
