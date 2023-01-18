package com.kurrency.data.infrastructure

import io.ktor.client.HttpClient
import io.ktor.client.call.body
import io.ktor.client.plugins.ResponseException
import io.ktor.client.request.request
import io.ktor.client.request.setBody
import io.ktor.client.utils.EmptyContent
import io.ktor.http.HttpMethod
import kotlin.collections.HashMap
import kotlin.collections.List
import kotlin.collections.forEach
import kotlin.collections.joinToString
import kotlin.collections.set

internal class ApiExecutor(private val httpClient: HttpClient) {

    private lateinit var endpoint: String

    private lateinit var httpMethod: HttpMethod

    private var body: Any = EmptyContent

    private var query: HashMap<String, String> = HashMap()

    fun setEndpoint(endpoint: String): ApiExecutor {
        this.endpoint = endpoint
        return this
    }

    fun setHttpMethod(httpMethod: HttpMethod): ApiExecutor {
        this.httpMethod = httpMethod
        return this
    }

    fun setBody(body: Any): ApiExecutor {
        this.body = body
        return this
    }

    fun addQuery(key: String, value: String): ApiExecutor {
        this.query[key] = value
        return this
    }

    fun addQuery(key: String, value: List<String>): ApiExecutor {
        this.query[key] = value.joinToString()
        return this
    }

    suspend inline fun <reified T> execute(): ApiResult<T> {
        return try {
            val response = httpClient.request(endpoint) {
                url{ query.forEach { parameters.append(it.key, it.value) } }
                setHttpMethod(httpMethod)
                setBody(body)
            }
            val result = response.body<T>()
            ApiResult(result, response.status.value)
        } catch (responseException: ResponseException) {
            responseException.toApiResult()
        } catch (throwable: Throwable) {
            throwable.toApiResult()
        }
    }

    private fun <T> ResponseException.toApiResult(): ApiResult<T> {
        return ApiResult(
            code = this.response.status.value,
            throwable = this.cause
        )
    }

    private fun <T> Throwable.toApiResult(): ApiResult<T> {
        return ApiResult(
            code = null,
            throwable = this.cause
        )
    }
}
