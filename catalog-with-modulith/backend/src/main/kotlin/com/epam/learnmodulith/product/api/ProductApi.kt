package com.epam.learnmodulith.product.api

import org.springframework.data.domain.Page
import org.springframework.data.domain.Pageable
import java.math.BigDecimal

/**
 * Public API for the Product module.
 * Other modules should interact with products through this interface.
 */
interface ProductApi {
    /**
     * Finds a product by its ID.
     * @param id The product ID
     * @return Product information if found, null otherwise
     */
    fun findById(id: Long): ProductInfo?

    /**
     * Finds multiple products by their IDs.
     * @param ids List of product IDs
     * @return List of product information (may contain fewer items than requested if some IDs don't exist)
     */
    fun findByIds(ids: List<Long>): List<ProductInfo>

    /**
     * Finds all products by category ID.
     * @param categoryId The category ID
     * @return List of products in the category
     */
    fun findByCategoryId(categoryId: Long): List<ProductInfo>

    /**
     * Finds all products by category path (including nested categories).
     * @param categoryPath The category path (e.g., "/1/5")
     * @return List of products in the category and its subcategories
     */
    fun findByCategoryPath(categoryPath: String): List<ProductInfo>

    /**
     * Finds all products by category path (including nested categories) with pagination.
     * @param categoryPath The category path (e.g., "/1/5")
     * @param pageable The pagination information
     * @return Page of products in the category and its subcategories
     */
    fun findByCategoryPath(categoryPath: String, pageable: Pageable): Page<ProductInfo>

    /**
     * Adds quantity to product stock (e.g. after restocking).
     * @param productId The product ID
     * @param quantity The quantity to add
     * @throws NoSuchElementException if product is not found
     */
    fun addStock(productId: Long, quantity: Int)
}

/**
 * Product information exposed to other modules.
 */
data class ProductInfo(
    val id: Long,
    val name: String,
    val shortDescription: String?,
    val price: BigDecimal,
    val status: String,
    val categoryId: Long  // Reference to category, not entity
)

