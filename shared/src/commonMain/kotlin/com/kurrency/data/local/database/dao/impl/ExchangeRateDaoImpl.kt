package com.kurrency.data.local.database.dao.impl

import com.kurrency.data.local.database.AppDatabase
import com.kurrency.data.local.database.dao.ExchangeRateDao
import com.kurrency.data.local.database.entity.ExchangeRateEntity

internal class ExchangeRateDaoImpl(database: AppDatabase): ExchangeRateDao {

    private val dbQuery = database.appDatabaseQueries

    override fun update(exchangeRateEntity: ExchangeRateEntity): ExchangeRateEntity {
        return ExchangeRateEntity()
    }

    override fun create(exchangeRateEntity: ExchangeRateEntity): ExchangeRateEntity {
        return ExchangeRateEntity()
    }

    override fun get(baseCurrency: String): ExchangeRateEntity {
        return ExchangeRateEntity()
    }
}