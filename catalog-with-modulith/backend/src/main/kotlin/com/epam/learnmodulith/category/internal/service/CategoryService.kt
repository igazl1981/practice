package com.epam.learnmodulith.category.internal.service

import com.epam.learnmodulith.category.internal.model.Category
import com.epam.learnmodulith.category.internal.repository.CategoryRepository
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional

@Service
@Transactional(readOnly = true)
class CategoryService(
    private val categoryRepository: CategoryRepository
) {
    fun findMainCategories(): List<Category> {
        return categoryRepository.findByParentIsNull()
    }

    fun findById(id: Long): Category? {
        return categoryRepository.findById(id).orElse(null)
    }

    fun findAllDescendantsByPath(path: String): List<Category> {
        return categoryRepository.findAllDescendantsByPath(path)
    }

    fun findDirectChildrenByParentId(parentId: Long?): List<Category> {
        // If parentId is null, return main categories (no parent)
        if (parentId == null) {
            return categoryRepository.findByParentIsNull()
        }

        // Verify parent category exists
        categoryRepository.findById(parentId)
            .orElseThrow { IllegalArgumentException("Category not found with id: $parentId") }

        // Return direct children of this category
        return categoryRepository.findByParentId(parentId)
    }
}

