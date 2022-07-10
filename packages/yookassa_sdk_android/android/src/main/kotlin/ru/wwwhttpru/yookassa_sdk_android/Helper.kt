package ru.wwwhttpru.yookassa_sdk_android

import android.graphics.Color
import kotlinx.serialization.json.*
import kotlinx.serialization.serializer
import ru.yoomoney.sdk.kassa.payments.TokenizationResult
import ru.yoomoney.sdk.kassa.payments.checkoutParameters.*
import ru.yoomoney.sdk.kassa.payments.ui.color.ColorScheme
import java.util.*
import kotlin.reflect.full.createType

/**
My knowledge of kotlin is terrible :D
https://github.com/Kotlin/kotlinx.serialization/issues/746
 */
fun Any?.toJsonElement(): JsonElement = when (this) {
    null -> JsonNull
    is JsonElement -> this
    is Number -> JsonPrimitive(this)
    is Boolean -> JsonPrimitive(this)
    is String -> JsonPrimitive(this)
    is Array<*> -> JsonArray(map { it.toJsonElement() })
    is List<*> -> JsonArray(map { it.toJsonElement() })
    is Map<*, *> -> JsonObject(map { it.key.toString() to it.value.toJsonElement() }.toMap())
    else -> Json.encodeToJsonElement(serializer(this::class.createType()), this)
}

fun convertAmount(data: AmountModel): Amount {
    return Amount(
            value = data.value.toBigDecimal(),
            currency = Currency.getInstance(data.currency.value),
    )
}

fun convertPaymentMethodTypes(data: TokenizationSettingsModel): Set<PaymentMethodType> {
    return data.paymentMethodTypes.rawValue.map {
        it.toPaymentMethodType()
    }.toSet()
}

fun convertGooglePayParameters(data: GooglePayParametersModel?): GooglePayParameters {
    val parameters = data ?: return GooglePayParameters();
    return GooglePayParameters(
            allowedCardNetworks = parameters.allowedCardNetworks.map {
                it.toGooglePayCardNetwork()
            }.toSet(),
    )
}

fun convertTestParameters(testModeSettings: TestModeSettingsModel?, showLogs: Boolean): TestParameters {
    val data = testModeSettings ?: return TestParameters(showLogs = showLogs)
    return TestParameters(
            showLogs = showLogs,
            googlePayTestEnvironment = data.googlePayTestEnvironment,
            mockConfiguration = MockConfiguration(
                    completeWithError = data.enablePaymentError,
                    paymentAuthPassed = data.paymentAuthorizationPassed,
                    linkedCardsCount = data.cardsCount,
                    serviceFee = convertAmount(data.charge),
            ),
    )
}

fun convertUiParameters(settings: CustomizationSettingsModel): UiParameters {
    return UiParameters(
            showLogo = settings.showYookassaLogo,
            colorScheme = ColorScheme(
                    primaryColor = Color.parseColor(settings.mainScheme),
            ),
    )
}

fun SavePaymentMethodEnum.toSavePaymentMethod(): SavePaymentMethod {
    return when (this) {
        SavePaymentMethodEnum.ON -> SavePaymentMethod.ON
        SavePaymentMethodEnum.OFF -> SavePaymentMethod.OFF
        SavePaymentMethodEnum.USER_SELECT -> SavePaymentMethod.USER_SELECTS
    }
}

fun PaymentMethodTypeEnum.toPaymentMethodType(): PaymentMethodType {
    return when (this) {
        PaymentMethodTypeEnum.BANKCARD -> PaymentMethodType.BANK_CARD
        PaymentMethodTypeEnum.SBERBANK -> PaymentMethodType.SBERBANK
        PaymentMethodTypeEnum.GOOGLE_PAY -> PaymentMethodType.GOOGLE_PAY
        PaymentMethodTypeEnum.YOO_MONEY -> PaymentMethodType.YOO_MONEY
        PaymentMethodTypeEnum.APPLE_PAY -> PaymentMethodType.GOOGLE_PAY
    }
}

fun GooglePayCardNetworkEnum.toGooglePayCardNetwork(): GooglePayCardNetwork {
    return when (this) {
        GooglePayCardNetworkEnum.AMEX -> GooglePayCardNetwork.AMEX
        GooglePayCardNetworkEnum.DISCOVER -> GooglePayCardNetwork.DISCOVER
        GooglePayCardNetworkEnum.JCB -> GooglePayCardNetwork.JCB
        GooglePayCardNetworkEnum.MASTERCARD -> GooglePayCardNetwork.MASTERCARD
        GooglePayCardNetworkEnum.VISA -> GooglePayCardNetwork.VISA
        GooglePayCardNetworkEnum.INTERAC -> GooglePayCardNetwork.INTERAC
        GooglePayCardNetworkEnum.OTHER -> GooglePayCardNetwork.OTHER
    }
}

fun TokenizationResult.toMap(): HashMap<String, String> = hashMapOf(
        "token" to this.paymentToken,
        "payment_method" to when (this.paymentMethodType) {
            PaymentMethodType.SBERBANK -> "sberbank"
            PaymentMethodType.BANK_CARD -> "bank_card"
            PaymentMethodType.GOOGLE_PAY -> "google_pay"
            PaymentMethodType.YOO_MONEY -> "yoo_money"
        }
)