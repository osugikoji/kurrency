package com.kurrency.data.remote.api

import com.kurrency.data.infrastructure.ApiResult
import com.kurrency.data.remote.dto.RateDto

interface CurrencyApi {

    suspend fun getRate(
        baseCurrency: String,
        currencies: List<String> = emptyList()
    ): ApiResult<RateDto>
}
