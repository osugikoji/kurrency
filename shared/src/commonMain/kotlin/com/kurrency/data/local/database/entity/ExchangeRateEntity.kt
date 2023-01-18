package com.kurrency.data.local.database.entity

class ExchangeRateEntity  {
    var baseCurrency: String = ""
    var rates: Map<String, Double> = emptyMap()
}