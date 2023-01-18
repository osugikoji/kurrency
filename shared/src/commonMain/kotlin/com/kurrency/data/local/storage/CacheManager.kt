package com.kurrency.data.local.storage

interface CacheManager {

    fun putString(key: String, value: String)

    fun getString(key: String, defaultValue: String = ""): String

    fun putBoolean(key: String, value: Boolean)

    fun getBoolean(key: String, defaultValue: Boolean = false): Boolean
}
