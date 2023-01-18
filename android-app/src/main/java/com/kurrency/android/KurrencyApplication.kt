package com.kurrency.android

import android.app.Application
import com.kurrency.android.core.CacheManagerImpl
import com.kurrency.KurrencySetup
import com.kurrency.setApplication

class KurrencyApplication : Application() {

    override fun onCreate() {
        super.onCreate()

        KurrencySetup.Builder()
            .setCacheManager(CacheManagerImpl())
            .setApplication(this)
            .start()
    }
}
