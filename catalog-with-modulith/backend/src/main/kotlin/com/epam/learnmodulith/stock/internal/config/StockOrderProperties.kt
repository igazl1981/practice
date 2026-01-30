package com.epam.learnmodulith.stock.internal.config

import org.springframework.boot.context.properties.ConfigurationProperties
import java.nio.file.Path
import java.nio.file.Paths

@ConfigurationProperties(prefix = "stock.order")
data class StockOrderProperties(
    /** Divisor for extra amount: extra = missing / extraDivisor (integer division). Default 3. */
    val extraDivisor: Int = 3,
    /** Output directory for generated order files. Default: current directory. */
    val outputPath: Path = Paths.get(".").toAbsolutePath().normalize()
)
