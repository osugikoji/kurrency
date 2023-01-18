package com.kurrency.domain.enums

enum class CurrencyCode(val description: String) {
    BRL("Brazil Real" ),
    CAD("Canada Dollar"),
    CNY("China Yuan Renminbi"),
    EUR("Euro Member Countries"),
    JPY("Japan Yen"),
    KRW("Korea (South) Won"),
    USD("United States Dollar"),
    NONE("");

    companion object {
        fun allCurrencies(): List<CurrencyCode> {
            return values().filter { it != NONE }
        }
    }
}
