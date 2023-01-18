package com.kurrency.di.modules

import com.kurrency.ContextHolder
import com.kurrency.data.local.database.AppDatabase
import com.squareup.sqldelight.android.AndroidSqliteDriver
import com.squareup.sqldelight.db.SqlDriver
import io.ktor.client.engine.android.Android
import org.koin.dsl.module

actual fun platformDataModule() = module {
    single { Android.create() }
    single<SqlDriver> {
        AndroidSqliteDriver(AppDatabase.Schema, ContextHolder.requiredContext(), "kurrency.db")
    }
}
