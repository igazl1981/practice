package com.epam.learnmodulith.category.internal.repository

import com.epam.learnmodulith.category.internal.model.Category
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.Query
import org.springframework.data.repository.query.Param
import org.springframework.stereotype.Repository

@Repository
interface CategoryRepository : JpaRepository<Category, Long> {

    fun findByParentIsNull(): List<Category>

    @Query("SELECT c FROM Category c WHERE c.path = :categoryPath OR c.path LIKE CONCAT(:categoryPath, '/%')")
    fun findAllDescendantsByPath(@Param("categoryPath") categoryPath: String): List<Category>

    fun findByPath(path: String): Category?

    fun findByParentId(parentId: Long): List<Category>
}

