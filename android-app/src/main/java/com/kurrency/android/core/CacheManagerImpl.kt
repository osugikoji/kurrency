package com.kurrency.android.core

import com.kurrency.data.local.storage.CacheManager

class CacheManagerImpl: CacheManager {

    override fun putString(key: String, value: String) {

    }

    override fun getString(key: String, defaultValue: String): String {
        return ""
    }

    override fun putBoolean(key: String, value: Boolean) {

    }

    override fun getBoolean(key: String, defaultValue: Boolean): Boolean {
        return false
    }
}