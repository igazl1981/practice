package com.epam.learnmodulith.demo

/**
 * Demo event used in integration tests to demonstrate asynchronous event handling.
 * The listener runs with @Async; the publisher returns immediately.
 */
data class AsyncTimingDemoEvent(val id: String = "async-demo")
