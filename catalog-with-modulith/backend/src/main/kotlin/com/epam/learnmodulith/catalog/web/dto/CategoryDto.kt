package com.epam.learnmodulith.catalog.web.dto

data class CategoryDto(
    val id: Long,
    val name: String,
    val description: String?,
    val image: String?,
    val level: Int,
    val parentId: Long?
)
