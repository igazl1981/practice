package com.epam.learnmodulith.cart.internal.service

import com.epam.learnmodulith.cart.internal.model.Cart
import com.epam.learnmodulith.cart.internal.repository.CartItemRepository
import com.epam.learnmodulith.cart.internal.repository.CartRepository
import org.springframework.stereotype.Component
import org.springframework.transaction.annotation.Transactional
import java.math.BigDecimal
import java.time.LocalDateTime

/**
 * Handles price calculations for carts.
 * Calculates total prices and updates cart totals.
 */
@Component
class CartPriceCalculator(
    private val cartItemRepository: CartItemRepository,
    private val cartRepository: CartRepository
) {

    /**
     * Calculates the total price of all items in a cart.
     * Uses the stored price in cart items (not current product price).
     * @param cartId The cart ID
     * @return The total price as BigDecimal
     */
    fun calculateTotalPrice(cartId: Long): BigDecimal {
        val items = cartItemRepository.findByCartId(cartId)
        if (items.isEmpty()) {
            return BigDecimal.ZERO
        }

        var total = BigDecimal.ZERO
        for (item in items) {
            // Use stored price from cart item (not current product price)
            total = total.add(item.price.multiply(BigDecimal(item.quantity)))
        }
        return total
    }

    /**
     * Updates the cart's total price and saves it.
     * @param cart The cart to update
     * @return The updated cart
     */
    @Transactional
    fun updateCartTotal(cart: Cart): Cart {
        val totalPrice = calculateTotalPrice(cart.id!!)
        return cartRepository.save(cart.copy(totalPrice = totalPrice, updatedAt = LocalDateTime.now()))
    }
}
