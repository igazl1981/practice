package com.epam.learnmodulith.category.api

import com.epam.learnmodulith.category.internal.model.Category
import com.epam.learnmodulith.category.internal.service.CategoryService
import org.springframework.stereotype.Component

/**
 * Implementation of the CategoryApi interface.
 * This provides a public API facade for other modules to interact with the category module.
 */
@Component
class CategoryApiImpl(
    private val categoryService: CategoryService
) : CategoryApi {

    override fun findById(id: Long): CategoryInfo? {
        return categoryService.findById(id)?.toInfo()
    }

    override fun findMainCategories(): List<CategoryInfo> {
        return categoryService.findMainCategories().map { it.toInfo() }
    }

    override fun findAllDescendantsByPath(path: String): List<CategoryInfo> {
        return categoryService.findAllDescendantsByPath(path).map { it.toInfo() }
    }

    override fun findDirectChildrenByParentId(parentId: Long?): List<CategoryInfo> {
        return categoryService.findDirectChildrenByParentId(parentId).map { it.toInfo() }
    }

    private fun Category.toInfo(): CategoryInfo {
        return CategoryInfo(
            id = id!!,
            name = name,
            description = description,
            image = image,
            path = path,
            level = level,
            parentId = parent?.id
        )
    }
}
