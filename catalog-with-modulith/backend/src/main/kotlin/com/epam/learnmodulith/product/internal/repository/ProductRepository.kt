package com.epam.learnmodulith.product.internal.repository

import com.epam.learnmodulith.product.internal.model.Product
import org.springframework.data.domain.Page
import org.springframework.data.domain.Pageable
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.Query
import org.springframework.data.repository.query.Param
import org.springframework.stereotype.Repository

@Repository
interface ProductRepository : JpaRepository<Product, Long> {

    fun findByCategoryId(categoryId: Long): List<Product>

    @Query("""
        SELECT p FROM Product p 
        WHERE p.categoryId IN :categoryIds
        ORDER BY p.name
    """)
    fun findAllByCategoryIds(@Param("categoryIds") categoryIds: List<Long>): List<Product>

    @Query("""
        SELECT p FROM Product p 
        WHERE p.categoryId IN :categoryIds
        ORDER BY p.name
    """)
    fun findAllByCategoryIds(@Param("categoryIds") categoryIds: List<Long>, pageable: Pageable): Page<Product>
}

