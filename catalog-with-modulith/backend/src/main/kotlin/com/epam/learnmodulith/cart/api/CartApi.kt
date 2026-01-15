package com.epam.learnmodulith.cart.api

/**
 * Public API for the Cart module.
 * Other modules should interact with carts through this interface.
 */
interface CartApi {
    /**
     * Finds a cart by its ID.
     * @param id The cart ID
     * @return Cart information if found, null otherwise
     */
    fun findById(id: Long): CartInfo?

    /**
     * Gets all items in a cart.
     * @param cartId The cart ID
     * @return List of cart items
     */
    fun getCartItems(cartId: Long): List<CartItemInfo>
}

/**
 * Cart information exposed to other modules.
 */
data class CartInfo(
    val id: Long,
    val status: String,
    val createdAt: java.time.LocalDateTime,
    val updatedAt: java.time.LocalDateTime
)

/**
 * Cart item information exposed to other modules.
 */
data class CartItemInfo(
    val id: Long,
    val cartId: Long,
    val productId: Long,
    val quantity: Int,
    val createdAt: java.time.LocalDateTime,
    val updatedAt: java.time.LocalDateTime
)
