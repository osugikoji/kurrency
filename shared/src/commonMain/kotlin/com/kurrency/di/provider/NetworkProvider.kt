package com.kurrency.di.provider

import io.github.aakira.napier.Napier
import io.ktor.client.HttpClient
import io.ktor.client.engine.HttpClientEngine
import io.ktor.client.plugins.HttpTimeout
import io.ktor.client.plugins.contentnegotiation.ContentNegotiation
import io.ktor.client.plugins.defaultRequest
import io.ktor.client.plugins.logging.LogLevel
import io.ktor.client.plugins.logging.Logger
import io.ktor.client.plugins.logging.Logging
import io.ktor.http.URLProtocol
import io.ktor.serialization.kotlinx.json.json
import kotlinx.serialization.json.Json

internal object NetworkProvider {

    private const val BASE_URL = "api.freecurrencyapi.com"
    private const val API_KEY = "UmWW0mJGCeACLqfBnFGTmpGMhyBA42Ak7ol3zjKT"

    fun provideHttpClient(engine: HttpClientEngine): HttpClient {
        return HttpClient(engine) {
            defaultRequest {
                url {
                    host = BASE_URL
                    url { protocol = URLProtocol.HTTPS }
                    parameters.append("apikey", API_KEY)
                }
            }
            install(Logging) {
                level = LogLevel.ALL
                logger = object : Logger {
                    override fun log(message: String) {
                        Napier.e(tag = "Http Client", message = message)
                    }
                }
            }
            install(ContentNegotiation) {
                json(Json {
                    prettyPrint = true
                    isLenient = true
                    ignoreUnknownKeys = true
                })
            }
        }
    }
}
