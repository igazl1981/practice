package com.epam.learnmodulith.category.internal.model

import jakarta.persistence.*
import java.time.LocalDateTime

@Entity
@Table(name = "categories")
data class Category(
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    val id: Long? = null,

    @Column(nullable = false, length = 255)
    val name: String,

    @Column(columnDefinition = "TEXT")
    val description: String? = null,

    @Column(length = 255)
    val image: String? = null,

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "parent_id")
    val parent: Category? = null,

    @Column(nullable = false, length = 1000)
    val path: String = "/",

    @Column(nullable = false)
    val level: Int = 0,

    @Column(name = "created_at", nullable = false, updatable = false)
    val createdAt: LocalDateTime = LocalDateTime.now(),

    @Column(name = "updated_at", nullable = false)
    val updatedAt: LocalDateTime = LocalDateTime.now()
)

