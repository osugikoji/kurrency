package com.kurrency

import android.app.Application
import android.content.Context

internal object ContextHolder {
    var application: Application? = null

    fun requiredContext(): Context {
        return application?.applicationContext
            ?: error("Application context not initialized. Call the setApplication from KurrencySetup.Builder.")
    }
}

fun KurrencySetup.Builder.setApplication(application: Application): KurrencySetup.Builder {
    ContextHolder.application = application
    return this
}
