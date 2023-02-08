package com.kurrency

import com.kurrency.data.local.storage.CacheManager
import com.kurrency.di.modules.DataModule
import com.kurrency.di.modules.DomainModule
import com.kurrency.di.modules.platformDataModule
import kotlin.native.concurrent.ThreadLocal
import org.koin.core.KoinApplication
import org.koin.core.context.startKoin

@ThreadLocal
object KurrencySetup {

    private var koinApp: KoinApplication? = null

    fun getKoinApp(): KoinApplication {
        return koinApp
            ?: error("KoinApplication not initialized. Call start method from KurrencySetup.Builder")
    }

    class Builder {
        private lateinit var cacheManager: CacheManager

        fun setCacheManager(cacheManager: CacheManager): Builder {
            this.cacheManager = cacheManager
            return this
        }

        fun start() {
            if (!::cacheManager.isInitialized) {
                error("Provide CacheManager instance through setCacheManager method.")
            }
            initializeDi()
        }

        private fun initializeDi() {
            val modules = DataModule(cacheManager).buildModules() +
                    DomainModule().buildModules() +
                    platformDataModule()
            koinApp = startKoin { modules(modules) }
        }
    }
}