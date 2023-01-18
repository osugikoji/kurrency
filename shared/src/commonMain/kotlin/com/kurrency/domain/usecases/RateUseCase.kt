package com.kurrency.domain.usecases

import com.kurrency.domain.enums.CurrencyCode
import com.kurrency.data.local.database.dao.ExchangeRateDao
import com.kurrency.data.local.database.entity.ExchangeRateEntity
import com.kurrency.data.local.storage.CacheManager
import com.kurrency.data.remote.api.CurrencyApi
import kotlinx.coroutines.async
import kotlinx.coroutines.coroutineScope

class RateUseCase(
    private val currencyApi: CurrencyApi,
    private val exchangeRateDao: ExchangeRateDao,
    private val cacheManager: CacheManager,
) {

    suspend fun fetchRatesIfNeeded(): Boolean {
        val hasFetched = cacheManager.getBoolean(HAS_FETCHED_RATINGS)
        if (!hasFetched) {
            val isFetched = fetchRates()
            cacheManager.putBoolean(HAS_FETCHED_RATINGS, isFetched)
            return isFetched
        }
        return true
    }

    suspend fun fetchRates(): Boolean = runCatching {
        var ratings = coroutineScope {
            CurrencyCode.allCurrencies().map { currencyCode ->
                async {
                    val rateDto = currencyApi.getRate(currencyCode.name).getBodyOrThrow()
                    return@async ExchangeRateEntity().apply {
                        baseCurrency = currencyCode.name
                        rates = rateDto.data
                    }
                }.await()
            }
        }
        ratings = ratings.map {
            exchangeRateDao.update(it)
        }
        ratings.isNotEmpty()
    }.isSuccess

    fun convertValue(
        baseCurrency: CurrencyCode,
        toCurrency: CurrencyCode,
        value: Double
    ): Double {
//        val toCurrencyCode = toCurrency.name.uppercase()
//        val baseCurrencyRates = exchangeRateDao.get(baseCurrency.name) ?: return 0.0
//        val toCurrencyRate = baseCurrencyRates.rates[toCurrencyCode]
//            ?: error("Could not find rate value for the given $toCurrencyCode currency symbol.")
//        return value * toCurrencyRate
        if (toCurrency == CurrencyCode.USD) {
            return value * 5
        }
        return value * 0.1234
    }

    companion object {
        private const val HAS_FETCHED_RATINGS = "has.fetched.ratings"
    }
}