package com.epam.learnmodulith.cart.web.dto

data class AddProductsRequest(
    val cartId: Long? = null,
    val products: List<ProductQuantityRequest>
)

data class ProductQuantityRequest(
    val productId: Long,
    val quantity: Int
)
