package com.epam.learnmodulith.cart.api

import com.epam.learnmodulith.cart.internal.model.Cart
import com.epam.learnmodulith.cart.internal.model.CartItem
import com.epam.learnmodulith.cart.internal.service.CartService
import org.springframework.stereotype.Component

/**
 * Implementation of the CartApi interface.
 * This provides a public API facade for other modules to interact with the cart module.
 */
@Component
class CartApiImpl(
    private val cartService: CartService
) : CartApi {

    override fun findById(id: Long): CartInfo? {
        return cartService.getCartById(id)?.toInfo()
    }

    override fun getCartItems(cartId: Long): List<CartItemInfo> {
        return cartService.getCartItems(cartId).map { it.toInfo() }
    }

    private fun Cart.toInfo(): CartInfo {
        return CartInfo(
            id = id!!,
            status = status.name,
            createdAt = createdAt,
            updatedAt = updatedAt
        )
    }

    private fun CartItem.toInfo(): CartItemInfo {
        return CartItemInfo(
            id = id!!,
            cartId = cart.id!!,
            productId = productId,
            quantity = quantity,
            createdAt = createdAt,
            updatedAt = updatedAt
        )
    }
}
