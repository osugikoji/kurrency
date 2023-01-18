package com.kurrency.data.infrastructure

/** Encapsulates an outcome from data a source. */
data class ApiResult<T>(
    val body: T? = null,
    val code: Int? = null,
    val headers: Map<String, List<String>> = mapOf(),
    val throwable: Throwable? = null,
) {

    val isSuccessful: Boolean = throwable == null

    /** Try to get [body], if it is null an [IllegalStateException] will be thrown. */
    fun getBodyOrThrow(): T {
        val exception = throwable
            ?: IllegalStateException("Could not retrieve body from SourceResult.")
        return body ?: throw exception
    }

    /** Throw an [throwable] when [isSuccessful] if false. */
    fun ensureSuccess() {
        if (!isSuccessful)
            throw throwable ?: IllegalStateException("Api request was not successful.")
    }
}
