package com.epam.learnmodulith

import com.epam.learnmodulith.demo.AsyncTimingDemoEvent
import com.epam.learnmodulith.demo.EventListenerTimingTestConfig
import com.epam.learnmodulith.demo.SyncTimingDemoEvent
import org.assertj.core.api.Assertions.assertThat
import org.junit.jupiter.api.Test
import org.springframework.beans.factory.annotation.Qualifier
import org.springframework.boot.test.context.SpringBootTest
import org.springframework.context.ApplicationEventPublisher
import org.springframework.test.context.TestConstructor
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.context.annotation.Import
import org.springframework.scheduling.annotation.EnableAsync
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor
import java.util.concurrent.TimeUnit
import java.util.concurrent.atomic.AtomicBoolean
import org.awaitility.Awaitility.await
import org.slf4j.LoggerFactory

/**
 * Integration test that demonstrates the difference between synchronous and
 * asynchronous ApplicationEventListener behavior:
 *
 * - **Sync listener:** The event publisher does not return until the listener
 *   has finished. So publishing to a listener that sleeps ~1s causes the
 *   publish call to take ~1s.
 *
 * - **Async listener:** The event publisher returns immediately; the listener
 *   runs in another thread. So publishing to an @Async listener that sleeps ~1s
 *   returns in milliseconds, and the listener completes later.
 *
 * Uses a minimal Spring context (no JPA/web) so the test runs without a database.
 */
@SpringBootTest(classes = [EventListenerSyncAsyncIntegrationTest.MinimalEventContext::class])
@TestConstructor(autowireMode = TestConstructor.AutowireMode.ALL)
class EventListenerSyncAsyncIntegrationTest(
    private val eventPublisher: ApplicationEventPublisher,
    @Qualifier("syncListenerDone") private val syncListenerDone: AtomicBoolean,
    @Qualifier("asyncListenerDone") private val asyncListenerDone: AtomicBoolean
) {

    private val log = LoggerFactory.getLogger(EventListenerSyncAsyncIntegrationTest::class.java)

    @Configuration
    @EnableAsync
    @Import(EventListenerTimingTestConfig::class)
    class MinimalEventContext {

        @Bean
        fun taskExecutor(): ThreadPoolTaskExecutor =
            ThreadPoolTaskExecutor().apply {
                corePoolSize = 2
                setThreadNamePrefix("async-demo-")
                initialize()
            }
    }

    @Test
    fun `sync listener - publisher waits until listener finishes`() {
        syncListenerDone.set(false)
        log.info("[TEST] Publishing SYNC event from thread: {} (publisher will BLOCK until listener finishes)", Thread.currentThread().name)
        val start = System.currentTimeMillis()
        eventPublisher.publishEvent(SyncTimingDemoEvent())
        val elapsed = System.currentTimeMillis() - start
        log.info("[TEST] Publish returned after {} ms - same thread as test, listener already finished", elapsed)

        assertThat(elapsed).isGreaterThanOrEqualTo(900)
        assertThat(syncListenerDone.get()).isTrue()
    }

    @Test
    fun `async listener - publisher returns immediately and listener runs in background`() {
        asyncListenerDone.set(false)
        log.info("[TEST] Publishing ASYNC event from thread: {} (publisher will return IMMEDIATELY)", Thread.currentThread().name)
        val start = System.currentTimeMillis()
        eventPublisher.publishEvent(AsyncTimingDemoEvent())
        val elapsed = System.currentTimeMillis() - start
        log.info("[TEST] Publish returned after {} ms - listener still running in another thread", elapsed)

        assertThat(elapsed).isLessThan(500)
        await().atMost(3, TimeUnit.SECONDS).untilTrue(asyncListenerDone)
        log.info("[TEST] Async listener has finished in background")
    }
}
