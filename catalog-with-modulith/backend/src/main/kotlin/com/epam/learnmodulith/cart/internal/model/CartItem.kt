package com.epam.learnmodulith.cart.internal.model

import jakarta.persistence.*
import java.time.LocalDateTime

@Entity
@Table(
    name = "cart_items",
    uniqueConstraints = [UniqueConstraint(columnNames = ["cart_id", "product_id"])]
)
data class CartItem(
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    val id: Long? = null,

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "cart_id", nullable = false)
    val cart: Cart,

    @Column(name = "product_id", nullable = false)
    val productId: Long,  // Store ID reference, not JPA relationship

    @Column(nullable = false)
    val quantity: Int,

    @Column(name = "created_at", nullable = false, updatable = false)
    val createdAt: LocalDateTime = LocalDateTime.now(),

    @Column(name = "updated_at", nullable = false)
    val updatedAt: LocalDateTime = LocalDateTime.now()
)
