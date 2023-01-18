package com.kurrency.di.modules

import com.kurrency.data.local.database.AppDatabase
import com.squareup.sqldelight.db.SqlDriver
import com.squareup.sqldelight.drivers.native.NativeSqliteDriver
import io.ktor.client.engine.darwin.Darwin
import org.koin.dsl.module

actual fun platformDataModule() = module {
    single { Darwin.create() }
    single<SqlDriver> { NativeSqliteDriver(AppDatabase.Schema, "kurrency.db") }
}