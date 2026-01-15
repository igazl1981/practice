package com.epam.learnmodulith.cart.internal.repository

import com.epam.learnmodulith.cart.internal.model.Cart
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository

@Repository
interface CartRepository : JpaRepository<Cart, Long>
