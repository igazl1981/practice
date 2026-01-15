package com.epam.learnmodulith.cart.web.controller

import com.epam.learnmodulith.cart.internal.service.CartService
import com.epam.learnmodulith.cart.internal.service.ProductQuantity
import com.epam.learnmodulith.cart.web.dto.*
import com.epam.learnmodulith.product.api.ProductApi
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*
import java.math.BigDecimal

@RestController
@RequestMapping("/api/carts")
class CartController(
    private val cartService: CartService,
    private val productApi: ProductApi
) {

    @PostMapping
    fun addProducts(@RequestBody request: AddProductsRequest): ResponseEntity<CartDto> {
        val productQuantities = request.products.map {
            ProductQuantity(it.productId, it.quantity)
        }
        val cart = cartService.addProducts(request.cartId, productQuantities)
        val cartDto = toCartDto(cart)
        return ResponseEntity.status(HttpStatus.CREATED).body(cartDto)
    }

    @PutMapping("/{cartId}/items")
    fun changeQuantities(
        @PathVariable cartId: Long,
        @RequestBody request: ChangeQuantitiesRequest
    ): ResponseEntity<CartDto> {
        val productQuantities = request.products.map {
            ProductQuantity(it.productId, it.quantity)
        }
        val cart = cartService.changeProductQuantities(cartId, productQuantities)
        val cartDto = toCartDto(cart)
        return ResponseEntity.ok(cartDto)
    }

    @DeleteMapping("/{cartId}/items")
    fun removeProducts(
        @PathVariable cartId: Long,
        @RequestBody request: RemoveProductsRequest
    ): ResponseEntity<CartDto> {
        val cart = cartService.removeProducts(cartId, request.productIds)
        val cartDto = toCartDto(cart)
        return ResponseEntity.ok(cartDto)
    }

    @PostMapping("/{cartId}/cancel")
    fun cancelCart(@PathVariable cartId: Long): ResponseEntity<CartDto> {
        val cart = cartService.cancelCart(cartId)
        val cartDto = toCartDto(cart)
        return ResponseEntity.ok(cartDto)
    }

    @PostMapping("/{cartId}/submit")
    fun submitCart(@PathVariable cartId: Long): ResponseEntity<CartDto> {
        val cart = cartService.submitCart(cartId)
        val cartDto = toCartDto(cart)
        return ResponseEntity.ok(cartDto)
    }

    @GetMapping("/{cartId}")
    fun getCart(@PathVariable cartId: Long): ResponseEntity<CartDto> {
        val cart = cartService.getCartById(cartId)
            ?: return ResponseEntity.notFound().build()
        val cartDto = toCartDto(cart)
        return ResponseEntity.ok(cartDto)
    }

    private fun toCartDto(cart: com.epam.learnmodulith.cart.internal.model.Cart): CartDto {
        val items = cartService.getCartItems(cart.id!!)
        val itemDtos = items.map { item ->
            val product = productApi.findById(item.productId)
            CartItemDto(
                id = item.id!!,
                productId = item.productId,
                productName = product?.name,
                productPrice = product?.price,
                quantity = item.quantity,
                itemTotal = product?.price?.multiply(BigDecimal(item.quantity)),
                createdAt = item.createdAt,
                updatedAt = item.updatedAt
            )
        }

        return CartDto(
            id = cart.id,
            status = cart.status.name,
            items = itemDtos,
            createdAt = cart.createdAt,
            updatedAt = cart.updatedAt
        )
    }
}
