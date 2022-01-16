package com.example.flutter_yookassa_sdk

import android.graphics.Color
import ru.yoomoney.sdk.kassa.payments.checkoutParameters.*
import ru.yoomoney.sdk.kassa.payments.ui.color.ColorScheme
import java.util.*
import kotlin.collections.Map

fun fetchAmount(argsAmount: Map<*, *>): Amount {
    val value = argsAmount["value"] as Double
    val currencyArgs = argsAmount["currency"] as Map<*, *>
    val currency = currencyArgs["value"] as String
    return Amount(value.toBigDecimal(), Currency.getInstance(currency))
}


fun fetchTestParameters(args: Map<*, *>) : TestParameters {
    val testModeSettingsArgs = args["testModeSettings"] as Map<*, *>?
    var mockConfiguration: MockConfiguration? = null
    var googlePayTestEnvironment = false
    if (testModeSettingsArgs != null) {
        val completeWithError = testModeSettingsArgs["enablePaymentError"] as Boolean
        val paymentAuthPassed = testModeSettingsArgs["paymentAuthorizationPassed"] as Boolean
        val linkedCardsCount = testModeSettingsArgs["cardsCount"] as Int
        val serviceFee = fetchAmount(testModeSettingsArgs["charge"] as Map<*, *>)
        mockConfiguration = MockConfiguration(
                completeWithError,
                paymentAuthPassed,
                linkedCardsCount,
                serviceFee
        )
        googlePayTestEnvironment = testModeSettingsArgs["googlePayTestEnvironment"] as Boolean? ?: false
    }
    val showLogs = args["isLoggingEnabled"] as Boolean
    return TestParameters(
            showLogs = showLogs,
            googlePayTestEnvironment = googlePayTestEnvironment,
            mockConfiguration = mockConfiguration
    )
}

fun fetchUiParameters(args: Map<*, *>, showLogo: Boolean) : UiParameters {
    val customizationSettingsArgs = args["customizationSettings"] as Map<*, *>
    val primaryColor = Color.parseColor(customizationSettingsArgs["mainScheme"] as String)
    val colorScheme = ColorScheme(primaryColor = primaryColor)
    return UiParameters(
            showLogo = showLogo,
            colorScheme = colorScheme
    )
}

fun String.toSavePaymentMethod(): SavePaymentMethod {
    return when (this) {
        "on" -> SavePaymentMethod.ON
        "off" -> SavePaymentMethod.OFF
        "user_selects" -> SavePaymentMethod.USER_SELECTS
        else -> SavePaymentMethod.USER_SELECTS
    }
}

fun String.toPaymentMethodType(): PaymentMethodType {
    return when (this) {
        "yoo_money" -> PaymentMethodType.YOO_MONEY
        "bank_card" -> PaymentMethodType.BANK_CARD
        "sberbank" -> PaymentMethodType.SBERBANK
        "google_pay" -> PaymentMethodType.GOOGLE_PAY
        else -> PaymentMethodType.GOOGLE_PAY
    }
}

fun String.toGooglePayCardNetwork(): GooglePayCardNetwork {
    return when (this) {
        "AMEX" -> GooglePayCardNetwork.AMEX
        "DISCOVER" -> GooglePayCardNetwork.DISCOVER
        "JCB" -> GooglePayCardNetwork.JCB
        "VISA" -> GooglePayCardNetwork.VISA
        "MASTERCARD" -> GooglePayCardNetwork.MASTERCARD
        "INTERAC" -> GooglePayCardNetwork.INTERAC
        "OTHER" -> GooglePayCardNetwork.OTHER
        else -> GooglePayCardNetwork.OTHER
    }
}