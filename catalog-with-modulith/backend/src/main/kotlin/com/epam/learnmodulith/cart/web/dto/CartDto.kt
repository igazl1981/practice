package com.epam.learnmodulith.cart.web.dto

import java.math.BigDecimal
import java.time.LocalDateTime

data class CartDto(
    val id: Long,
    val status: String,
    val items: List<CartItemDto>,
    val totalPrice: BigDecimal,
    val createdAt: LocalDateTime,
    val updatedAt: LocalDateTime
)
