package com.kurrency.data.remote.api.impl

import com.kurrency.data.infrastructure.ApiExecutor
import com.kurrency.data.infrastructure.ApiResult
import com.kurrency.data.remote.api.CurrencyApi
import com.kurrency.data.remote.dto.RateDto
import io.ktor.http.HttpMethod

internal class CurrencyApiImpl(private val apiExecutor: ApiExecutor) : CurrencyApi {

    override suspend fun getRate(
        baseCurrency: String,
        currencies: List<String>
    ): ApiResult<RateDto> {
        return apiExecutor
            .setEndpoint("v1/latest")
            .setHttpMethod(HttpMethod.Get)
            .addQuery("base_currency", baseCurrency)
            .addQuery("currencies", currencies)
            .execute()
    }
}
