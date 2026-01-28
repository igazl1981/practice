package com.epam.learnmodulith.product.internal.service

import com.epam.learnmodulith.category.api.CategoryApi
import com.epam.learnmodulith.product.api.ProductStockLowEvent
import com.epam.learnmodulith.product.internal.model.Product
import com.epam.learnmodulith.product.internal.repository.ProductRepository
import org.slf4j.LoggerFactory
import org.springframework.context.ApplicationEventPublisher
import org.springframework.data.domain.Page
import org.springframework.data.domain.Pageable
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional
import java.time.LocalDateTime

@Service
@Transactional(readOnly = true)
class ProductService(
    private val productRepository: ProductRepository,
    private val categoryApi: CategoryApi,  // Dependency on Category module via API
    private val eventPublisher: ApplicationEventPublisher
) {
    private val logger = LoggerFactory.getLogger(ProductService::class.java)
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

    /**
     * Deducts stock for products based on cart submission.
     * Publishes ProductStockLowEvent when stock goes below 0.
     * @param productQuantities Map of product ID to quantity to deduct
     */
    @Transactional
    fun deductStock(productQuantities: Map<Long, Int>) {
        if (productQuantities.isEmpty()) {
            return
        }

        val productIds = productQuantities.keys.toList()
        val productMap = productRepository.findAllById(productIds).associateBy { it.id!! }

        for ((productId, quantity) in productQuantities) {
            val product = productMap[productId]
            if (product == null) {
                logger.warn("Product with ID $productId not found when deducting stock. Skipping.")
                continue
            }

            val newStock = product.stock - quantity
            val updatedProduct = product.copy(
                stock = newStock,
                updatedAt = LocalDateTime.now()
            )
            productRepository.save(updatedProduct)
            logger.debug("Deducted stock for product $productId: ${product.stock} -> $newStock")

            // Publish low stock event if stock goes below 0
            if (newStock < 0) {
                logger.warn("Product ${product.name} (ID: $productId) stock is now below 0: $newStock")
                eventPublisher.publishEvent(
                    ProductStockLowEvent(
                        productId = productId,
                        currentStock = newStock
                    )
                )
            }
        }
    }
}

