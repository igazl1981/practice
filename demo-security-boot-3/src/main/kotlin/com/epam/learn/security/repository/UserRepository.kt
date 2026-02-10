package com.epam.learn.security.repository

import com.epam.learn.security.domain.AppUser
import org.springframework.data.jpa.repository.JpaRepository

interface UserRepository : JpaRepository<AppUser, Long> {

    fun findByUsername(username: String): AppUser?
}
