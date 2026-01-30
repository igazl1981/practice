package com.epam.learnmodulith.stock.internal.config

import org.springframework.boot.context.properties.EnableConfigurationProperties
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.scheduling.annotation.EnableAsync
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor

@Configuration
@EnableAsync
@EnableConfigurationProperties(StockOrderProperties::class)
class StockConfig {

    @Bean("stockOrderEventExecutor")
    fun stockOrderEventExecutor(): ThreadPoolTaskExecutor =
        ThreadPoolTaskExecutor().apply {
            corePoolSize = 1
            maxPoolSize = 1
            setThreadNamePrefix("stock-order-event-")
            setWaitForTasksToCompleteOnShutdown(true)
            initialize()
        }
}
