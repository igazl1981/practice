package com.epam.learnmodulith.demo

import org.slf4j.LoggerFactory
import org.springframework.beans.factory.annotation.Qualifier
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.context.event.EventListener
import org.springframework.scheduling.annotation.Async
import java.util.concurrent.atomic.AtomicBoolean

/**
 * Test configuration that registers sync and async listeners for timing-demo events.
 * Used by EventListenerSyncAsyncIntegrationTest to show that sync listeners block
 * the publisher and async listeners do not.
 */
@Configuration
class EventListenerTimingTestConfig {

    @Bean
    fun syncListenerDone(): AtomicBoolean = AtomicBoolean(false)

    @Bean
    fun asyncListenerDone(): AtomicBoolean = AtomicBoolean(false)

    @Bean
    fun syncTimingDemoListener(@Qualifier("syncListenerDone") done: AtomicBoolean): SyncTimingDemoListener =
        SyncTimingDemoListener(done)

    @Bean
    fun asyncTimingDemoListener(@Qualifier("asyncListenerDone") done: AtomicBoolean): AsyncTimingDemoListener =
        AsyncTimingDemoListener(done)
}

/**
 * Listener for SyncTimingDemoEvent. No @Async, so the event publisher
 * waits until this method returns.
 */
open class SyncTimingDemoListener(private val done: AtomicBoolean) {

    private val log = LoggerFactory.getLogger(SyncTimingDemoListener::class.java)

    @EventListener
    open fun handle(event: SyncTimingDemoEvent) {
        val thread = Thread.currentThread().name
        log.info("[SYNC] Listener started on thread: {}", thread)
        val start = System.currentTimeMillis()
        Thread.sleep(1000)
        done.set(true)
        log.info("[SYNC] Listener finished on thread: {} (took {} ms)", thread, System.currentTimeMillis() - start)
    }
}

/**
 * Listener for AsyncTimingDemoEvent. Method is @Async so the event publisher
 * returns immediately while this runs in another thread.
 */
open class AsyncTimingDemoListener(private val done: AtomicBoolean) {

    private val log = LoggerFactory.getLogger(AsyncTimingDemoListener::class.java)

    @Async
    @EventListener
    open fun handle(event: AsyncTimingDemoEvent) {
        val thread = Thread.currentThread().name
        log.info("[ASYNC] Listener started on thread: {}", thread)
        val start = System.currentTimeMillis()
        Thread.sleep(1000)
        done.set(true)
        log.info("[ASYNC] Listener finished on thread: {} (took {} ms)", thread, System.currentTimeMillis() - start)
    }
}
