package com.epam.learnmodulith.cart.internal.service

import com.epam.learnmodulith.product.api.ProductApi
import org.springframework.stereotype.Component
import java.math.BigDecimal

/**
 * Validates products for cart operations.
 * Handles fetching and validating that products exist and are active.
 */
@Component
class ProductValidator(
    private val productApi: ProductApi
) {

    /**
     * Fetches and validates products by their IDs.
     * This is a convenience method that combines fetchProductsByIds() and validateProducts().
     * @param productIds List of product IDs to fetch and validate
     * @return Map of productId to ProductInfo
     * @throws IllegalArgumentException if any product is not found or not active
     */
    fun fetchAndValidateProducts(productIds: List<Long>): Map<Long, Product> {
        val productMap = fetchProductsByIds(productIds)
        validateProducts(productIds, productMap)
        return productMap
    }

    /**
     * Batch fetches products by IDs and returns a map for quick lookup.
     * @param productIds List of product IDs to fetch
     * @return Map of productId to ProductInfo
     */
    private fun fetchProductsByIds(productIds: List<Long>): Map<Long, Product> {
        val products = productApi.findByIds(productIds).map { Product(it.id, it.price, it.status) }
        return products.associateBy { it.id }
    }

    /**
     * Validates that all products exist and are active.
     * @param productIds List of product IDs to validate
     * @param productMap Map of productId to ProductInfo
     * @throws IllegalArgumentException if any product is not found or not active
     */
    private fun validateProducts(
        productIds: List<Long>,
        productMap: Map<Long, Product>
    ) {
        for (productId in productIds) {
            val product = productMap[productId]
                ?: throw IllegalArgumentException("Product not found with id: $productId")
            if (product.status != "ACTIVE") {
                throw IllegalArgumentException("Product $productId is not active (status: ${product.status})")
            }
        }
    }

    data class Product(val id: Long, val price: BigDecimal, val status: String)
}
