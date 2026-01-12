package com.epam.learnmodulith

import io.swagger.v3.oas.annotations.OpenAPIDefinition
import io.swagger.v3.oas.annotations.info.Info
import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication
import org.springframework.modulith.core.ApplicationModules

@SpringBootApplication
@OpenAPIDefinition(
    info = Info(
        title = "Learn Modulith Backend API",
        version = "v1",
        description = "API documentation for the Learn Modulith backend"
    )
)
class BackendApplication

fun main(args: Array<String>) {
    ApplicationModules.of(BackendApplication::class.java)
        .forEach { println(it) }

    runApplication<BackendApplication>(*args)
}
