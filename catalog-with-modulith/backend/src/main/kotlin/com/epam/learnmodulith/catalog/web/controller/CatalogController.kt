package com.epam.learnmodulith.catalog.web.controller

import com.epam.learnmodulith.catalog.internal.service.CatalogService
import com.epam.learnmodulith.catalog.web.dto.CategoryDto
import com.epam.learnmodulith.catalog.web.dto.ProductDto
import org.springframework.data.domain.Page
import org.springframework.data.domain.Pageable
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*

@RestController
@RequestMapping("/api/catalog")
class CatalogController(
    private val catalogService: CatalogService
) {

    @GetMapping("/categories")
    fun getCategories(@RequestParam(required = false) parentId: Long?): ResponseEntity<List<CategoryDto>> {
        val categories = catalogService.getCategoriesByParentId(parentId)
        return ResponseEntity.ok(categories)
    }

    @GetMapping("/categories/{categoryId}/products")
    fun getProductsByCategory(
        @PathVariable categoryId: Long,
        pageable: Pageable
    ): ResponseEntity<Page<ProductDto>> {
        val products = catalogService.getProductsByCategory(categoryId, pageable)
        return ResponseEntity.ok(products)
    }

    @GetMapping("/products/{productId}")
    fun getProductById(@PathVariable productId: Long): ResponseEntity<ProductDto> {
        val product = catalogService.getProductById(productId)
        return ResponseEntity.ok(product)
    }

    @GetMapping("/categories/{categoryId}")
    fun getCategoryById(@PathVariable categoryId: Long): ResponseEntity<CategoryDto> {
        val category = catalogService.getCategoryById(categoryId)
        return ResponseEntity.ok(category)
    }
}
