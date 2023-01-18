package com.kurrency.data.local.database.dao

import com.kurrency.data.local.database.entity.ExchangeRateEntity

interface ExchangeRateDao {

    fun update(exchangeRateEntity: ExchangeRateEntity): ExchangeRateEntity

    fun create(exchangeRateEntity: ExchangeRateEntity): ExchangeRateEntity

    fun get(baseCurrency: String): ExchangeRateEntity
}
