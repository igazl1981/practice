package com.epam.learnmodulith.product.api

import com.epam.learnmodulith.product.internal.model.Product
import com.epam.learnmodulith.product.internal.service.ProductService
import org.springframework.data.domain.Page
import org.springframework.data.domain.Pageable
import org.springframework.stereotype.Component

/**
 * Implementation of the ProductApi interface.
 * This provides a public API facade for other modules to interact with the product module.
 */
@Component
class ProductApiImpl(
    private val productService: ProductService
) : ProductApi {

    override fun findById(id: Long): ProductInfo? {
        return productService.findById(id)?.toInfo()
    }

    override fun findByCategoryId(categoryId: Long): List<ProductInfo> {
        return productService.findByCategoryId(categoryId).map { it.toInfo() }
    }

    override fun findByCategoryPath(categoryPath: String): List<ProductInfo> {
        return productService.findByCategoryPath(categoryPath).map { it.toInfo() }
    }

    override fun findByCategoryPath(categoryPath: String, pageable: Pageable): Page<ProductInfo> {
        return productService.findByCategoryPath(categoryPath, pageable).map { it.toInfo() }
    }

    private fun Product.toInfo(): ProductInfo {
        return ProductInfo(
            id = id!!,
            name = name,
            shortDescription = shortDescription,
            price = price,
            status = status.name,
            categoryId = categoryId
        )
    }
}

