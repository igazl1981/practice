package com.epam.learnmodulith.cart.internal.repository

import com.epam.learnmodulith.cart.internal.model.CartItem
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.Query
import org.springframework.data.repository.query.Param
import org.springframework.stereotype.Repository

@Repository
interface CartItemRepository : JpaRepository<CartItem, Long> {

    fun findByCartId(cartId: Long): List<CartItem>

    @Query("SELECT ci FROM CartItem ci WHERE ci.cart.id = :cartId AND ci.productId = :productId")
    fun findByCartIdAndProductId(@Param("cartId") cartId: Long, @Param("productId") productId: Long): CartItem?

    @Query("SELECT ci FROM CartItem ci WHERE ci.cart.id = :cartId AND ci.productId IN :productIds")
    fun findByCartIdAndProductIds(@Param("cartId") cartId: Long, @Param("productIds") productIds: List<Long>): List<CartItem>
}
