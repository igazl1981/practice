package com.epam.learn.security.config

import com.epam.learn.security.repository.UserRepository
import org.springframework.security.core.authority.SimpleGrantedAuthority
import org.springframework.security.core.userdetails.User
import org.springframework.security.core.userdetails.UserDetails
import org.springframework.security.core.userdetails.UserDetailsService
import org.springframework.security.core.userdetails.UsernameNotFoundException
import org.springframework.stereotype.Service

@Service
class DatabaseUserDetailsService(
    private val userRepository: UserRepository
) : UserDetailsService {

    override fun loadUserByUsername(username: String): UserDetails {
        val appUser = userRepository.findByUsername(username)
            ?: throw UsernameNotFoundException("User not found: $username")
        val authorities = appUser.roles.map { SimpleGrantedAuthority(it) }.toSet()
        return User(appUser.username, appUser.password, authorities)
    }
}
