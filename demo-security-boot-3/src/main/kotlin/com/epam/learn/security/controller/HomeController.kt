package com.epam.learn.security.controller

import org.springframework.security.core.annotation.AuthenticationPrincipal
import org.springframework.security.core.userdetails.UserDetails
import org.springframework.stereotype.Controller
import org.springframework.ui.Model
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RequestMapping

@Controller
@RequestMapping
class HomeController {

    @GetMapping("/", "/home")
    fun home(
        model: Model,
        @AuthenticationPrincipal principal: UserDetails?
    ): String {
        model.addAttribute("username", principal?.username)
        return "index"
    }
}
