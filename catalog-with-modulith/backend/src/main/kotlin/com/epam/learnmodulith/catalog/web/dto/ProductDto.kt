package com.epam.learnmodulith.catalog.web.dto

import java.math.BigDecimal

data class ProductDto(
    val id: Long,
    val name: String,
    val shortDescription: String?,
    val price: BigDecimal,
    val status: String,
    val category: CategoryDto
)
