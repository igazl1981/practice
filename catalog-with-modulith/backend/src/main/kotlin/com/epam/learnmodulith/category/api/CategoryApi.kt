package com.epam.learnmodulith.category.api

/**
 * Public API for the Category module.
 * Other modules should interact with categories through this interface.
 */
interface CategoryApi {
    /**
     * Finds a category by its ID.
     * @param id The category ID
     * @return Category information if found, null otherwise
     */
    fun findById(id: Long): CategoryInfo?

    /**
     * Finds all main categories (categories without a parent).
     * @return List of main categories
     */
    fun findMainCategories(): List<CategoryInfo>

    /**
     * Finds all descendant categories by path (including the category itself).
     * @param path The category path (e.g., "/1/5")
     * @return List of all categories in the path hierarchy
     */
    fun findAllDescendantsByPath(path: String): List<CategoryInfo>

    /**
     * Finds direct child categories by parent ID.
     * @param parentId The parent category ID. Use null for main categories.
     * @return List of direct child categories
     */
    fun findDirectChildrenByParentId(parentId: Long?): List<CategoryInfo>
}

/**
 * Category information exposed to other modules.
 */
data class CategoryInfo(
    val id: Long,
    val name: String,
    val description: String?,
    val image: String?,
    val path: String,
    val level: Int,
    val parentId: Long?
)
