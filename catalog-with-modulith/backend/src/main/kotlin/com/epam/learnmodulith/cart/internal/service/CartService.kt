package com.epam.learnmodulith.cart.internal.service

import com.epam.learnmodulith.cart.internal.model.Cart
import com.epam.learnmodulith.cart.internal.model.CartItem
import com.epam.learnmodulith.cart.internal.model.CartStatus
import com.epam.learnmodulith.cart.internal.repository.CartRepository
import com.epam.learnmodulith.product.api.ProductInfo
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional
import java.time.LocalDateTime

/**
 * Service for managing carts.
 * Orchestrates cart operations and delegates to specialized services.
 */
@Service
@Transactional
class CartService(
    private val cartRepository: CartRepository,
    private val cartItemService: CartItemService,
    private val productValidator: ProductValidator,
    private val cartPriceCalculator: CartPriceCalculator
) {

    /**
     * Adds products to a cart. If cartId is null, creates a new cart.
     * @param cartId The cart ID (null to create a new cart)
     * @param productQuantities List of product IDs and their quantities
     * @return The cart with added items
     */
    fun addProducts(cartId: Long?, productQuantities: List<ProductQuantity>): Cart {
        val cart = if (cartId == null) {
            createNewCart()
        } else {
            getActiveCartOrThrow(cartId)
        }

        // Batch fetch and validate products
        val productMap = productValidator.fetchAndValidateProducts(productQuantities.map { it.productId }.distinct())

        // Add or update cart items using the batch-fetched products
        for (productQuantity in productQuantities) {
            val product = productMap[productQuantity.productId]!!
            cartItemService.addOrUpdateCartItem(cart, productQuantity.productId, productQuantity.quantity, product.price)
        }

        return cartPriceCalculator.updateCartTotal(cart)
    }

    /**
     * Changes the quantity of products in a cart.
     * @param cartId The cart ID
     * @param productQuantities List of product IDs and their new quantities
     * @return The updated cart
     */
    fun changeProductQuantities(cartId: Long, productQuantities: List<ProductQuantity>): Cart {
        val cart = getActiveCartOrThrow(cartId)

        // Batch fetch and validate products
        val productMap = productValidator.fetchAndValidateProducts(productQuantities.map { it.productId }.distinct())

        for (productQuantity in productQuantities) {
            val cartItem = cartItemService.findByCartIdAndProductId(cartId, productQuantity.productId)
                ?: throw IllegalArgumentException("Product ${productQuantity.productId} not found in cart $cartId")

            val product = productMap[productQuantity.productId]!!

            if (productQuantity.quantity <= 0) {
                cartItemService.deleteCartItem(cartItem)
            } else {
                cartItemService.updateCartItemQuantity(cartItem, productQuantity.quantity, product.price)
            }
        }

        return cartPriceCalculator.updateCartTotal(cart)
    }

    /**
     * Removes products from a cart.
     * @param cartId The cart ID
     * @param productIds List of product IDs to remove
     * @return The updated cart
     */
    fun removeProducts(cartId: Long, productIds: List<Long>): Cart {
        val cart = getActiveCartOrThrow(cartId)
        cartItemService.removeCartItems(cartId, productIds)
        return cartPriceCalculator.updateCartTotal(cart)
    }

    /**
     * Cancels a cart.
     * @param cartId The cart ID
     * @return The cancelled cart
     */
    fun cancelCart(cartId: Long): Cart {
        val cart = getActiveCartOrThrow(cartId)
        return cartRepository.save(
            cart.copy(
                status = CartStatus.CANCELLED,
                updatedAt = LocalDateTime.now()
            )
        )
    }

    /**
     * Submits a cart (changes status to SUBMITTED).
     * Updates all item prices to current product prices before submission to ensure prices are frozen at submission time.
     * @param cartId The cart ID
     * @return The submitted cart
     */
    fun submitCart(cartId: Long): Cart {
        val cart = getActiveCartOrThrow(cartId)

        val items = cartItemService.findByCartId(cartId)
        if (items.isEmpty()) {
            throw IllegalStateException("Cannot submit an empty cart")
        }

        // Batch fetch and validate all products
        val productMap = productValidator.fetchAndValidateProducts(items.map { it.productId }.distinct())

        // Update all item prices to current product prices before submission
        // This ensures prices are frozen at the time of submission
        for (item in items) {
            val product = productMap[item.productId]!!
            cartItemService.updateCartItemPrice(item, product.price)
        }

        // Recalculate total with updated prices
        val totalPrice = cartPriceCalculator.calculateTotalPrice(cartId)

        return cartRepository.save(
            cart.copy(
                status = CartStatus.SUBMITTED,
                totalPrice = totalPrice,
                updatedAt = LocalDateTime.now()
            )
        )
    }

    /**
     * Gets a cart by ID with all its items.
     */
    @Transactional(readOnly = true)
    fun getCartById(cartId: Long): Cart? {
        return cartRepository.findById(cartId).orElse(null)
    }

    /**
     * Gets all items in a cart.
     */
    @Transactional(readOnly = true)
    fun getCartItems(cartId: Long): List<CartItem> {
        return cartItemService.findByCartId(cartId)
    }

    private fun createNewCart(): Cart {
        return cartRepository.save(Cart())
    }

    private fun getActiveCartOrThrow(cartId: Long): Cart {
        val cart = cartRepository.findById(cartId)
            .orElseThrow { IllegalArgumentException("Cart not found with id: $cartId") }

        if (cart.status != CartStatus.ACTIVE) {
            throw IllegalStateException("Cart $cartId is not active (status: ${cart.status})")
        }

        return cart
    }
}

/**
 * Data class representing a product and its quantity.
 */
data class ProductQuantity(
    val productId: Long,
    val quantity: Int
)
