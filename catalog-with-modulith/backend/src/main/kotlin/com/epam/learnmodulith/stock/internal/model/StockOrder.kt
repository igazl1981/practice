package com.epam.learnmodulith.stock.internal.model

import jakarta.persistence.*
import org.hibernate.annotations.JdbcTypeCode
import org.hibernate.type.SqlTypes
import java.time.LocalDateTime

enum class StockOrderStatus {
    OPEN,
    PENDING,
    CLOSED
}

@Entity
@Table(name = "stock_orders")
data class StockOrder(
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    val id: Long? = null,

    @Column(name = "created_at", nullable = false, updatable = false)
    val createdAt: LocalDateTime = LocalDateTime.now(),

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 20)
    var status: StockOrderStatus = StockOrderStatus.OPEN,

    @JdbcTypeCode(SqlTypes.JSON)
    @Column(nullable = false, columnDefinition = "jsonb")
    var products: MutableMap<String, Int> = mutableMapOf()
)
