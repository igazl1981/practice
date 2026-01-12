package com.epam.learnmodulith.catalog.internal.service

import com.epam.learnmodulith.catalog.web.dto.CategoryDto
import com.epam.learnmodulith.catalog.web.dto.ProductDto
import com.epam.learnmodulith.category.api.CategoryApi
import com.epam.learnmodulith.category.api.CategoryInfo
import com.epam.learnmodulith.product.api.ProductApi
import org.springframework.data.domain.Page
import org.springframework.data.domain.Pageable
import org.springframework.stereotype.Service

/**
 * Catalog service that orchestrates Product and Category modules.
 * This service combines data from both modules to provide unified catalog operations.
 */
@Service
class CatalogService(
    private val categoryApi: CategoryApi,
    private val productApi: ProductApi
) {

    fun getCategoriesByParentId(parentId: Long?): List<CategoryDto> {
        return categoryApi.findDirectChildrenByParentId(parentId)
            .map { it.toDto() }
    }

    fun getProductsByCategory(categoryId: Long, pageable: Pageable): Page<ProductDto> {
        // Get category to find its path
        val category = categoryApi.findById(categoryId)
            ?: throw IllegalArgumentException("Category not found with id: $categoryId")

        // Get products by category path (includes nested categories) with pagination
        val productsPage = productApi.findByCategoryPath(category.path, pageable)

        // Enrich products with category information
        return productsPage.map { product ->
            val productCategory = categoryApi.findById(product.categoryId)
                ?: throw IllegalStateException("Category not found for product: ${product.id}")

            ProductDto(
                id = product.id,
                name = product.name,
                shortDescription = product.shortDescription,
                price = product.price,
                status = product.status,
                category = productCategory.toDto()
            )
        }
    }

    fun getProductById(productId: Long): ProductDto {
        val product = productApi.findById(productId)
            ?: throw IllegalArgumentException("Product not found with id: $productId")

        val category = categoryApi.findById(product.categoryId)
            ?: throw IllegalStateException("Category not found for product: $productId")

        return ProductDto(
            id = product.id,
            name = product.name,
            shortDescription = product.shortDescription,
            price = product.price,
            status = product.status,
            category = category.toDto()
        )
    }

    fun getCategoryById(categoryId: Long): CategoryDto {
        val category = categoryApi.findById(categoryId)
            ?: throw IllegalArgumentException("Category not found with id: $categoryId")
        return category.toDto()
    }

    private fun CategoryInfo.toDto(): CategoryDto {
        return CategoryDto(
            id = id,
            name = name,
            description = description,
            image = image,
            level = level,
            parentId = parentId
        )
    }
}
