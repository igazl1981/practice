package com.epam.learnmodulith.cart.internal.model

import jakarta.persistence.*
import java.time.LocalDateTime

enum class CartStatus {
    ACTIVE,
    SUBMITTED,
    CANCELLED
}

@Entity
@Table(name = "carts")
data class Cart(
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    val id: Long? = null,

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 20)
    val status: CartStatus = CartStatus.ACTIVE,

    @Column(name = "created_at", nullable = false, updatable = false)
    val createdAt: LocalDateTime = LocalDateTime.now(),

    @Column(name = "updated_at", nullable = false)
    val updatedAt: LocalDateTime = LocalDateTime.now()
)
