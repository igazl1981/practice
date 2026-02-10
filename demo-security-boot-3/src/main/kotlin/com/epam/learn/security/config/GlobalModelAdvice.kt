package com.epam.learn.security.config

import org.springframework.security.core.Authentication
import org.springframework.security.core.context.SecurityContextHolder
import org.springframework.security.core.userdetails.UserDetails
import org.springframework.web.bind.annotation.ControllerAdvice
import org.springframework.web.bind.annotation.ModelAttribute

@ControllerAdvice
class GlobalModelAdvice {

    @ModelAttribute("username")
    fun username(): String? {
        val auth: Authentication? = SecurityContextHolder.getContext().authentication
        val principal = auth?.principal
        return when (principal) {
            is UserDetails -> principal.username
            else -> null
        }
    }
}
