package com.epam.learnmodulith.product.api

/**
 * Event published when one or more products' stock goes below 0 after a cart submission.
 * Contains all affected products in one batch so listeners can update a single stock-order.
 */
data class ProductsStockLowEvent(
    val productQuantities: Map<Long, Int>  // product ID -> quantity to order (positive, amount under zero)
)
