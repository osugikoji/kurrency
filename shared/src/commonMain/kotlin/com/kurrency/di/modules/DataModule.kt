package com.kurrency.di.modules

import com.kurrency.data.infrastructure.ApiExecutor
import com.kurrency.data.local.database.AppDatabase
import com.kurrency.data.local.database.dao.ExchangeRateDao
import com.kurrency.data.local.database.dao.impl.ExchangeRateDaoImpl
import com.kurrency.data.local.storage.CacheManager
import com.kurrency.data.remote.api.CurrencyApi
import com.kurrency.data.remote.api.impl.CurrencyApiImpl
import com.kurrency.di.provider.NetworkProvider
import org.koin.core.Koin
import org.koin.core.module.Module
import org.koin.dsl.module

internal class DataModule(private val cacheManager: CacheManager) {

    fun buildModules(): List<Module> {
        return localModule +
                remoteModule +
                infrastructure
    }

    private val infrastructure = module {
        factory { ApiExecutor(get()) }
    }

    private val localModule = module {
        single { cacheManager }
        single { AppDatabase(get()) }
        single<ExchangeRateDao> { ExchangeRateDaoImpl(get()) }
    }

    private val remoteModule = module {
        single { NetworkProvider.provideHttpClient(get()) }
        single<CurrencyApi> { CurrencyApiImpl(get()) }
    }
}

expect fun platformDataModule(): Module

val Koin.cacheManager: CacheManager
    get() = get()