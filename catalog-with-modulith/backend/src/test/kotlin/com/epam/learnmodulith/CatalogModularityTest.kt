package com.epam.learnmodulith

import org.junit.jupiter.api.Test
import org.springframework.modulith.core.ApplicationModules

/**
 * Modularity test to verify Spring Modulith module structure and boundaries.
 *
 * This test ensures:
 * - Module boundaries are properly defined
 * - Internal packages are not accessible from outside
 * - API packages are correctly exposed
 * - No cyclic dependencies exist between modules
 */
class CatalogModularityTest {

    private val modules = ApplicationModules.of(BackendApplication::class.java)

    @Test
    fun `verify module structure`() {
        // Verify that modules are detected correctly and boundaries are respected
        modules.verify()
    }

    @Test
    fun `verify catalog module structure`() {
        val catalogModule = modules.getModuleByName("catalog")

        // Verify that the catalog module exists
        assert(catalogModule.isPresent) { "Catalog module should exist" }

        // Print dependencies for debugging
        val module = catalogModule.get()
        val dependencies = module.getDirectDependencies(modules)
        println("Catalog module dependencies: ${dependencies.stream().map { it.targetType.name }}")
    }

    @Test
    fun `verify category module exists`() {
        val categoryModule = modules.getModuleByName("category")
        assert(categoryModule.isPresent) { "Category module should exist" }
    }

    @Test
    fun `verify product module exists`() {
        val productModule = modules.getModuleByName("product")
        assert(productModule.isPresent) { "Product module should exist" }
    }

    @Test
    fun `verify stock module exists`() {
        val stockModule = modules.getModuleByName("stock")
        assert(stockModule.isPresent) { "Stock module should exist" }
    }

    @Test
    fun `verify stock depends on product`() {
        val stockModule = modules.getModuleByName("stock")
        assert(stockModule.isPresent) { "Stock module should exist" }

        val dependencies = stockModule.get().getDirectDependencies(modules)
        val dependsOnProduct = dependencies.uniqueModules().toList().any { it.identifier.toString() == "product" }
        assert(dependsOnProduct) { "Stock module should depend on Product module" }
    }

    @Test
    fun `verify product depends on category`() {
        val productModule = modules.getModuleByName("product")
        assert(productModule.isPresent) { "Product module should exist" }

        val dependencies = productModule.get().getDirectDependencies(modules)
        val dependsOnCategory = dependencies.uniqueModules().toList().any { it.identifier.toString() == "category" }
        assert(dependsOnCategory) { "Product module should depend on Category module" }
    }

    @Test
    fun `verify catalog depends on product and category`() {
        val catalogModule = modules.getModuleByName("catalog")
        assert(catalogModule.isPresent) { "Catalog module should exist" }

        val dependencies = catalogModule.get().getDirectDependencies(modules)
        val dependsOnProduct = dependencies.uniqueModules().toList().any { it.identifier.toString() == "product" }
        val dependsOnCategory = dependencies.uniqueModules().toList().any { it.identifier.toString() == "category" }

        assert(dependsOnProduct) { "Catalog module should depend on Product module" }
        assert(dependsOnCategory) { "Catalog module should depend on Category module" }
    }

    @Test
    fun `verify no illegal dependencies`() {
        // Verify that modules don't have illegal dependencies
        // This will fail if internal packages are accessed from outside
        modules.verify()
    }

//    @Test
//    fun `generate module documentation`() {
//        val outputFolder = Paths.get("target", "modulith-docs")
//
//        Documenter(modules)
//            .writeDocumentation()
//            .writeTo(outputFolder)
//    }

    @Test
    fun `list all modules`() {
        // Print all detected modules for debugging
        modules.forEach { module ->
            println("Module: ${module.identifier}")
            println("  Base package: ${module.basePackage}")
            println("  Allowed dependencies: ${module.getDirectDependencies(modules)}")
        }
    }
}

