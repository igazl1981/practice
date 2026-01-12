package com.epam.learnmodulith.product.internal.model

import jakarta.persistence.*
import java.math.BigDecimal
import java.time.LocalDateTime

enum class ProductStatus {
    ACTIVE,
    INACTIVE,
    DISCONTINUED
}

@Entity
@Table(name = "products")
data class Product(
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    val id: Long? = null,

    @Column(nullable = false, length = 255)
    val name: String,

    @Column(name = "short_description", length = 500)
    val shortDescription: String? = null,

    @Column(nullable = false, precision = 10, scale = 2)
    val price: BigDecimal,

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 20)
    val status: ProductStatus = ProductStatus.ACTIVE,

    @Column(name = "category_id", nullable = false)
    val categoryId: Long,  // Store ID reference, not JPA relationship

    @Column(name = "created_at", nullable = false, updatable = false)
    val createdAt: LocalDateTime = LocalDateTime.now(),

    @Column(name = "updated_at", nullable = false)
    val updatedAt: LocalDateTime = LocalDateTime.now()
)

