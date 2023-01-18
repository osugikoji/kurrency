package com.kurrency.domain.usecases

import com.kurrency.domain.enums.CurrencyCode
import com.kurrency.data.local.storage.CacheManager

class CurrentCurrencyUseCase(private val cacheManager: CacheManager) {

    fun getFromCurrency(): CurrencyCode {
        val currencyName = cacheManager.getString(FROM_CURRENCY_KEY).uppercase()
        val currencyCode = runCatching { CurrencyCode.valueOf(currencyName) }.getOrNull()
        return currencyCode ?: CurrencyCode.BRL
    }

    fun saveFromCurrency(currencyCode: CurrencyCode) {
        cacheManager.putString(FROM_CURRENCY_KEY, currencyCode.name)
    }

    fun getToCurrency(): CurrencyCode {
        val currencyName = cacheManager.getString(TO_CURRENCY_KEY).uppercase()
        val currencyCode = runCatching { CurrencyCode.valueOf(currencyName) }.getOrNull()
        return currencyCode ?: CurrencyCode.USD
    }

    fun saveToCurrency(currencyCode: CurrencyCode) {
        cacheManager.putString(TO_CURRENCY_KEY, currencyCode.name)
    }

//    suspend fun fetchCurrentCurrencyRate() {
//        val fromCurrency = getFromCurrency()
//        val toCurrency = getToCurrency()
//        coroutineScope {
//            async {
//                val rateDto = currencyApi.getRate(fromCurrency.name).body
//            }
//        }.await()
//        currencyApi.getRate()
//    }

    companion object {
        private const val FROM_CURRENCY_KEY = "from.currency"
        private const val TO_CURRENCY_KEY = "to.currency"
        private const val USD_CURRENCY_RATING = "to.currency"
    }
}