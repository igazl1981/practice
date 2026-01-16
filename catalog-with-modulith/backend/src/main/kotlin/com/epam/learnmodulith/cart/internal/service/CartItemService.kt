package com.epam.learnmodulith.cart.internal.service

import com.epam.learnmodulith.cart.internal.model.Cart
import com.epam.learnmodulith.cart.internal.model.CartItem
import com.epam.learnmodulith.cart.internal.repository.CartItemRepository
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional
import java.math.BigDecimal
import java.time.LocalDateTime

/**
 * Handles cart item operations.
 * Manages adding, updating, and removing cart items.
 */
@Service
@Transactional
class CartItemService(
    private val cartItemRepository: CartItemRepository
) {

    /**
     * Adds or updates a cart item.
     * If the item already exists, updates the price and adds to the quantity.
     * Otherwise, creates a new cart item.
     * @param cart The cart to add/update the item in
     * @param productId The product ID
     * @param quantity The quantity to add
     * @param currentPrice The current product price
     * @throws IllegalArgumentException if quantity is not greater than 0
     */
    fun addOrUpdateCartItem(cart: Cart, productId: Long, quantity: Int, currentPrice: BigDecimal) {
        if (quantity <= 0) {
            throw IllegalArgumentException("Quantity must be greater than 0")
        }

        val existingItem = cartItemRepository.findByCartIdAndProductId(cart.id!!, productId)

        if (existingItem != null) {
            // Update existing item: update price to current price and add to quantity
            // This ensures prices are always current before cart submission
            cartItemRepository.save(
                existingItem.copy(
                    price = currentPrice,  // Update price to current product price
                    quantity = existingItem.quantity + quantity,
                    updatedAt = LocalDateTime.now()
                )
            )
        } else {
            // Create new item with current product price
            cartItemRepository.save(
                CartItem(
                    cart = cart,
                    productId = productId,
                    price = currentPrice,  // Store current product price
                    quantity = quantity
                )
            )
        }
    }

    /**
     * Updates the quantity and price of an existing cart item.
     * @param cartItem The cart item to update
     * @param quantity The new quantity
     * @param currentPrice The current product price
     */
    fun updateCartItemQuantity(cartItem: CartItem, quantity: Int, currentPrice: BigDecimal) {
        cartItemRepository.save(
            cartItem.copy(
                price = currentPrice,  // Update price to current product price
                quantity = quantity,
                updatedAt = LocalDateTime.now()
            )
        )
    }

    /**
     * Updates the price of a cart item.
     * @param cartItem The cart item to update
     * @param currentPrice The current product price
     */
    fun updateCartItemPrice(cartItem: CartItem, currentPrice: BigDecimal) {
        cartItemRepository.save(
            cartItem.copy(
                price = currentPrice,  // Update to current price
                updatedAt = LocalDateTime.now()
            )
        )
    }

    /**
     * Deletes a single cart item.
     * @param cartItem The cart item to delete
     */
    fun deleteCartItem(cartItem: CartItem) {
        cartItemRepository.delete(cartItem)
    }

    /**
     * Removes cart items for the given product IDs.
     * @param cartId The cart ID
     * @param productIds List of product IDs to remove
     * @throws IllegalArgumentException if no products are found to remove
     */
    fun removeCartItems(cartId: Long, productIds: List<Long>) {
        val cartItems = cartItemRepository.findByCartIdAndProductIds(cartId, productIds)
        if (cartItems.isEmpty()) {
            throw IllegalArgumentException("No products found in cart $cartId to remove")
        }

        cartItemRepository.deleteAll(cartItems)
    }

    /**
     * Finds a cart item by cart ID and product ID.
     * @param cartId The cart ID
     * @param productId The product ID
     * @return The cart item if found, null otherwise
     */
    fun findByCartIdAndProductId(cartId: Long, productId: Long): CartItem? {
        return cartItemRepository.findByCartIdAndProductId(cartId, productId)
    }

    /**
     * Finds all cart items for a cart.
     * @param cartId The cart ID
     * @return List of cart items
     */
    fun findByCartId(cartId: Long): List<CartItem> {
        return cartItemRepository.findByCartId(cartId)
    }
}
