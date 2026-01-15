package com.epam.learnmodulith.cart.web.dto

import java.math.BigDecimal
import java.time.LocalDateTime

data class CartItemDto(
    val id: Long,
    val productId: Long,
    val productName: String?,
    val productPrice: BigDecimal?,
    val quantity: Int,
    val itemTotal: BigDecimal?,
    val createdAt: LocalDateTime,
    val updatedAt: LocalDateTime
)
