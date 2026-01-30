package com.epam.learnmodulith.demo

/**
 * Demo event used in integration tests to demonstrate synchronous event handling.
 * The listener sleeps ~1 second; the publisher waits until the listener finishes.
 */
data class SyncTimingDemoEvent(val id: String = "sync-demo")
