package com.kurrency.di.modules

import com.kurrency.domain.usecases.CurrentCurrencyUseCase
import com.kurrency.domain.usecases.RateUseCase
import org.koin.core.Koin
import org.koin.core.module.Module
import org.koin.dsl.module

internal class DomainModule {

    fun buildModules(): List<Module> {
        return listOf(useCaseModule)
    }

    private val useCaseModule = module {
        factory { RateUseCase(get(), get(), get()) }
        factory { CurrentCurrencyUseCase(get()) }
    }
}

val Koin.rateUseCase: RateUseCase
    get() = get()

val Koin.currentCurrencyUseCase: CurrentCurrencyUseCase
    get() = get()