package com.kurrency.data.remote.dto

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

@Serializable
data class RateDto(
    @SerialName("data")
    val data: Map<String, Double>
)
