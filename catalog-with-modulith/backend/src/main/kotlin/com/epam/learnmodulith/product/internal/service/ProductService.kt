package com.epam.learnmodulith.product.internal.service

import com.epam.learnmodulith.category.api.CategoryApi
import com.epam.learnmodulith.product.internal.model.Product
import com.epam.learnmodulith.product.internal.repository.ProductRepository
import org.springframework.data.domain.Page
import org.springframework.data.domain.Pageable
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional

@Service
@Transactional(readOnly = true)
class ProductService(
    private val productRepository: ProductRepository,
    private val categoryApi: CategoryApi  // Dependency on Category module via API
) {
    fun findById(id: Long): Product? {
        return productRepository.findById(id).orElse(null)
    }

    fun findByIds(ids: List<Long>): List<Product> {
        return productRepository.findAllById(ids)
    }

    fun findByCategoryId(categoryId: Long): List<Product> {
        return productRepository.findByCategoryId(categoryId)
    }

    fun findByCategoryPath(categoryPath: String): List<Product> {
        // Get all category IDs in the path (including descendants)
        val categories = categoryApi.findAllDescendantsByPath(categoryPath)
        val categoryIds = categories.map { it.id }

        if (categoryIds.isEmpty()) {
            return emptyList()
        }

        return productRepository.findAllByCategoryIds(categoryIds)
    }

    fun findByCategoryPath(categoryPath: String, pageable: Pageable): Page<Product> {
        // Get all category IDs in the path (including descendants)
        val categories = categoryApi.findAllDescendantsByPath(categoryPath)
        val categoryIds = categories.map { it.id }

        if (categoryIds.isEmpty()) {
            return Page.empty(pageable)
        }

        return productRepository.findAllByCategoryIds(categoryIds, pageable)
    }
}

