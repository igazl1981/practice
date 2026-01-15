package com.epam.learnmodulith.cart.internal.service

import com.epam.learnmodulith.cart.internal.model.Cart
import com.epam.learnmodulith.cart.internal.model.CartItem
import com.epam.learnmodulith.cart.internal.model.CartStatus
import com.epam.learnmodulith.cart.internal.repository.CartItemRepository
import com.epam.learnmodulith.cart.internal.repository.CartRepository
import com.epam.learnmodulith.product.api.ProductApi
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional
import java.time.LocalDateTime

@Service
@Transactional
class CartService(
    private val cartRepository: CartRepository,
    private val cartItemRepository: CartItemRepository,
    private val productApi: ProductApi
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

        for (productQuantity in productQuantities) {
            validateProduct(productQuantity.productId)
            addOrUpdateCartItem(cart, productQuantity.productId, productQuantity.quantity)
        }

        return cartRepository.save(cart.copy(updatedAt = LocalDateTime.now()))
    }

    /**
     * Changes the quantity of products in a cart.
     * @param cartId The cart ID
     * @param productQuantities List of product IDs and their new quantities
     * @return The updated cart
     */
    fun changeProductQuantities(cartId: Long, productQuantities: List<ProductQuantity>): Cart {
        val cart = getActiveCartOrThrow(cartId)

        for (productQuantity in productQuantities) {
            validateProduct(productQuantity.productId)
            val cartItem = cartItemRepository.findByCartIdAndProductId(cartId, productQuantity.productId)
                ?: throw IllegalArgumentException("Product ${productQuantity.productId} not found in cart $cartId")

            if (productQuantity.quantity <= 0) {
                cartItemRepository.delete(cartItem)
            } else {
                cartItemRepository.save(
                    cartItem.copy(
                        quantity = productQuantity.quantity,
                        updatedAt = LocalDateTime.now()
                    )
                )
            }
        }

        return cartRepository.save(cart.copy(updatedAt = LocalDateTime.now()))
    }

    /**
     * Removes products from a cart.
     * @param cartId The cart ID
     * @param productIds List of product IDs to remove
     * @return The updated cart
     */
    fun removeProducts(cartId: Long, productIds: List<Long>): Cart {
        val cart = getActiveCartOrThrow(cartId)

        val cartItems = cartItemRepository.findByCartIdAndProductIds(cartId, productIds)
        if (cartItems.isEmpty()) {
            throw IllegalArgumentException("No products found in cart $cartId to remove")
        }

        cartItemRepository.deleteAll(cartItems)

        return cartRepository.save(cart.copy(updatedAt = LocalDateTime.now()))
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
     * @param cartId The cart ID
     * @return The submitted cart
     */
    fun submitCart(cartId: Long): Cart {
        val cart = getActiveCartOrThrow(cartId)
        
        val items = cartItemRepository.findByCartId(cartId)
        if (items.isEmpty()) {
            throw IllegalStateException("Cannot submit an empty cart")
        }

        return cartRepository.save(
            cart.copy(
                status = CartStatus.SUBMITTED,
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
        return cartItemRepository.findByCartId(cartId)
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

    private fun validateProduct(productId: Long) {
        val product = productApi.findById(productId)
            ?: throw IllegalArgumentException("Product not found with id: $productId")
        
        if (product.status != "ACTIVE") {
            throw IllegalArgumentException("Product $productId is not active (status: ${product.status})")
        }
    }

    private fun addOrUpdateCartItem(cart: Cart, productId: Long, quantity: Int) {
        if (quantity <= 0) {
            throw IllegalArgumentException("Quantity must be greater than 0")
        }

        val existingItem = cartItemRepository.findByCartIdAndProductId(cart.id!!, productId)
        
        if (existingItem != null) {
            // Update existing item by adding to current quantity
            cartItemRepository.save(
                existingItem.copy(
                    quantity = existingItem.quantity + quantity,
                    updatedAt = LocalDateTime.now()
                )
            )
        } else {
            // Create new item
            cartItemRepository.save(
                CartItem(
                    cart = cart,
                    productId = productId,
                    quantity = quantity
                )
            )
        }
    }
}

/**
 * Data class representing a product and its quantity.
 */
data class ProductQuantity(
    val productId: Long,
    val quantity: Int
)
