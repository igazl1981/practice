package com.epam.learn.security

import org.junit.jupiter.api.Test
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc
import org.springframework.boot.test.context.SpringBootTest
import org.springframework.security.test.context.support.WithMockUser
import org.springframework.test.context.ActiveProfiles
import org.springframework.test.web.servlet.MockMvc
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get
import org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestPostProcessors.csrf
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post
import org.springframework.test.web.servlet.result.MockMvcResultMatchers.redirectedUrl
import org.springframework.test.web.servlet.result.MockMvcResultMatchers.status

@SpringBootTest
@AutoConfigureMockMvc
@ActiveProfiles("test")
class SecurityIntegrationTest {

    @Autowired
    private lateinit var mockMvc: MockMvc

    @Test
    fun `public page returns 200 without auth`() {
        mockMvc.perform(get("/public"))
            .andExpect(status().isOk)
    }

    @Test
    fun `landing without auth returns 200`() {
        mockMvc.perform(get("/"))
            .andExpect(status().isOk)
    }

    @Test
    fun `home without auth redirects to login`() {
        mockMvc.perform(get("/home"))
            .andExpect(status().isFound)
            .andExpect(redirectedUrl("http://localhost/login"))
    }

    @Test
    @WithMockUser
    fun `home with authenticated user returns 200`() {
        mockMvc.perform(get("/home"))
            .andExpect(status().isOk)
    }

    @Test
    @WithMockUser(roles = ["USER"])
    fun `admin page with USER role returns 403`() {
        mockMvc.perform(get("/admin"))
            .andExpect(status().isForbidden)
    }

    @Test
    @WithMockUser(roles = ["ADMIN"])
    fun `admin page with ADMIN role returns 200`() {
        mockMvc.perform(get("/admin"))
            .andExpect(status().isOk)
    }

    @Test
    fun `registration POST creates user and redirects to login`() {
        mockMvc.perform(
            post("/register")
                .param("username", "newuser")
                .param("password", "secret")
                .with(csrf())
        )
            .andExpect(status().isFound)
            .andExpect(redirectedUrl("/login"))
    }
}
