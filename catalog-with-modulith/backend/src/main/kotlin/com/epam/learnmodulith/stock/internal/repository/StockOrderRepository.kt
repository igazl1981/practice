package com.epam.learnmodulith.stock.internal.repository

import com.epam.learnmodulith.stock.internal.model.StockOrder
import com.epam.learnmodulith.stock.internal.model.StockOrderStatus
import jakarta.persistence.LockModeType
import jakarta.persistence.QueryHint
import org.springframework.data.domain.Pageable
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.Lock
import org.springframework.data.jpa.repository.Query
import org.springframework.data.jpa.repository.QueryHints
import java.time.LocalDateTime

interface StockOrderRepository : JpaRepository<StockOrder, Long> {

    @Lock(LockModeType.PESSIMISTIC_WRITE)
    @Query("SELECT o FROM StockOrder o WHERE o.status = :status ORDER BY o.createdAt ASC")
    fun findByStatusOrderByCreatedAtAscForUpdate(status: StockOrderStatus): List<StockOrder>

    @Lock(LockModeType.PESSIMISTIC_WRITE)
    @QueryHints(value = [QueryHint(name = "jakarta.persistence.lock.timeout", value = "-2")])
    @Query("SELECT o FROM StockOrder o WHERE o.status = :status ORDER BY o.createdAt DESC")
    fun findTopByStatusOrderByCreatedAtDescForUpdateSkipLocked(
        status: StockOrderStatus,
        pageable: Pageable
    ): List<StockOrder>

    @Query("SELECT o FROM StockOrder o WHERE o.status = :status AND o.createdAt < :before ORDER BY o.createdAt ASC")
    fun findByStatusAndCreatedAtBefore(
        status: StockOrderStatus,
        before: LocalDateTime
    ): List<StockOrder>
}
