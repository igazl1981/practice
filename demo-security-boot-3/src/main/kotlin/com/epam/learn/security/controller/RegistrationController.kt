package com.epam.learn.security.controller

import com.epam.learn.security.domain.AppUser
import com.epam.learn.security.repository.UserRepository
import org.springframework.security.crypto.password.PasswordEncoder
import org.springframework.stereotype.Controller
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestParam
import org.springframework.web.servlet.mvc.support.RedirectAttributes

@Controller
class RegistrationController(
    private val userRepository: UserRepository,
    private val passwordEncoder: PasswordEncoder
) {

    @GetMapping("/register")
    fun registerPage(): String = "register"

    @PostMapping("/register")
    fun register(
        @RequestParam username: String,
        @RequestParam password: String,
        redirectAttributes: RedirectAttributes
    ): String {
        if (username.isBlank()) {
            redirectAttributes.addFlashAttribute("error", "Username is required")
            return "redirect:/register"
        }
        if (userRepository.findByUsername(username) != null) {
            redirectAttributes.addFlashAttribute("error", "Username already exists")
            return "redirect:/register"
        }
        val encodedPassword = passwordEncoder.encode(password)
        val roles = mutableSetOf("ROLE_USER")
        userRepository.save(AppUser(username = username.trim(), password = encodedPassword, roles = roles))
        redirectAttributes.addFlashAttribute("message", "Registration successful. Please log in.")
        return "redirect:/login"
    }
}
