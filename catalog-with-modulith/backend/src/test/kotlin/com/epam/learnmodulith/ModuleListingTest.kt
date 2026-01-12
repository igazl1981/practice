package com.epam.learnmodulith

import org.junit.jupiter.api.Test
import org.springframework.modulith.core.ApplicationModules

/**
 * Simple modularity test that lists all modules in the application.
 *
 * This test uses Spring Modulith to detect and list all application modules
 * without performing thorough verification.
 */
class ModuleListingTest {

    private val modules = ApplicationModules.of(BackendApplication::class.java)

    @Test
    fun `list all application modules`() {
        println("=".repeat(60))
        println("Application Modules")
        println("=".repeat(60))

        modules.forEach { module ->
            println("\nModule: ${module.identifier}")
            println("  Base Package: ${module.basePackage}")
            println("  Display Name: ${module.displayName}")

            val dependencies = module.getDirectDependencies(modules)
            if (!dependencies.isEmpty()) {
                println("  Dependencies:")
                dependencies.stream().forEach { dep ->
                    println("    - ${dep.getTargetType()}")
                }
            } else {
                println("  Dependencies: None")
            }
        }

        println("\n" + "=".repeat(60))
        println("Total modules: ${modules.stream().count()}")
        println("=".repeat(60))
    }
}

