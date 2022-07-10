package ru.wwwhttpru.yookassa_sdk_android

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

/** TokenizationModuleInputData in Dart */
@Serializable
data class TokenizationModuleInputDataModel(
        @SerialName("amount")
        var amount: AmountModel,
        @SerialName("shop_name")
        var shopName: String,
        @SerialName("purchase_description")
        var purchaseDescription: String,
        @SerialName("client_application_key")
        var clientApplicationKey: String,
        @SerialName("shop_id")
        var shopId: String,
        @SerialName("save_payment_method")
        var savePaymentMethod: SavePaymentMethodEnum,
        @SerialName("gateway_id")
        val gatewayId: String?,
        @SerialName("is_logging_enabled")
        val isLoggingEnabled: Boolean,
        @SerialName("test_mode_settings")
        val testModeSettings: TestModeSettingsModel?,
        @SerialName("customization_settings")
        val customizationSettings: CustomizationSettingsModel,
        @SerialName("tokenization_settings")
        val tokenizationSettings: TokenizationSettingsModel,
        @SerialName("google_pay_parameters")
        val googlePayParameters: GooglePayParametersModel?,
        @SerialName("money_auth_client_id")
        val moneyAuthClientId: String?,
        @SerialName("user_phone_number")
        val userPhoneNumber: String?,
        @SerialName("custom_return_url")
        val customReturnUrl: String?,
        @SerialName("customer_id")
        val customerId: String?,
)

/** BankCardRepeatModuleInputData in Dart */
@Serializable
data class BankCardRepeatModuleInputDataModel(
        @SerialName("amount")
        var amount: AmountModel,
        @SerialName("shop_name")
        var shopName: String,
        @SerialName("purchase_description")
        var purchaseDescription: String,
        @SerialName("client_application_key")
        var clientApplicationKey: String,
        @SerialName("shop_id")
        var shopId: String,
        @SerialName("save_payment_method")
        var savePaymentMethod: SavePaymentMethodEnum,
        @SerialName("gateway_id")
        val gatewayId: String?,
        @SerialName("is_logging_enabled")
        val isLoggingEnabled: Boolean,
        @SerialName("test_mode_settings")
        val testModeSettings: TestModeSettingsModel?,
        @SerialName("customization_settings")
        val customizationSettings: CustomizationSettingsModel,
        @SerialName("payment_method_id")
        val paymentMethodId: String,
)

/** ConfirmInputData in Dart */
@Serializable
data class ConfirmInputDataModel(
        @SerialName("confirmation_url")
        var confirmationUrl: String,
        @SerialName("payment_method_type")
        val paymentMethodType: PaymentMethodTypeEnum,
        @SerialName("is_logging_enabled")
        val isLoggingEnabled: Boolean,
        @SerialName("test_mode_settings")
        val testModeSettings: TestModeSettingsModel?,
        @SerialName("customization_settings")
        val customizationSettings: CustomizationSettingsModel,
)

/** SavePaymentMethod in Dart */
@Serializable
enum class SavePaymentMethodEnum {
    @SerialName("on")
    ON,

    @SerialName("off")
    OFF,

    @SerialName("user_selects")
    USER_SELECT,
}

/** Amount in Dart */
@Serializable
data class AmountModel(
        @SerialName("value")
        val value: Double,
        @SerialName("currency")
        val currency: CurrencyModel
)

/** Currency in Dart */
@Serializable
data class CurrencyModel(
        @SerialName("value")
        val value: String,
)

/** TokenizationSettings in Dart */
@Serializable
data class TokenizationSettingsModel(
        @SerialName("payment_method_types")
        val paymentMethodTypes: PaymentMethodTypesModel,
)

/** PaymentMethodTypes in Dart */
@Serializable
data class PaymentMethodTypesModel(
        @SerialName("raw_value")
        val rawValue: Set<PaymentMethodTypeEnum>
)

/** PaymentMethodType in Dart */
@Serializable
enum class PaymentMethodTypeEnum {
    @SerialName("bank_card")
    BANKCARD,

    @SerialName("sberbank")
    SBERBANK,

    @SerialName("google_pay")
    GOOGLE_PAY,

    @SerialName("yoo_money")
    YOO_MONEY,

    @SerialName("apple_pay")
    APPLE_PAY,
}

/** TestModeSettings in Dart */
@Serializable
data class TestModeSettingsModel(
        @SerialName("payment_authorization_passed")
        val paymentAuthorizationPassed: Boolean,
        @SerialName("cards_count")
        val cardsCount: Int,
        @SerialName("charge")
        val charge: AmountModel,
        @SerialName("enable_payment_error")
        val enablePaymentError: Boolean,
        @SerialName("google_pay_test_environment")
        val googlePayTestEnvironment: Boolean,
)

/** CustomizationSettings in Dart */
@Serializable
data class CustomizationSettingsModel(
        @SerialName("main_scheme")
        val mainScheme: String,
        @SerialName("show_yookassa_logo")
        val showYookassaLogo: Boolean,
)

/** GooglePayCardNetwork in Dart */
@Serializable
enum class GooglePayCardNetworkEnum {
    @SerialName("amex")
    AMEX,

    @SerialName("discover")
    DISCOVER,

    @SerialName("jcb")
    JCB,

    @SerialName("mastercard")
    MASTERCARD,

    @SerialName("visa")
    VISA,

    @SerialName("interac")
    INTERAC,

    @SerialName("other")
    OTHER,
}

/** GooglePayParameters in Dart */
@Serializable
data class GooglePayParametersModel(
        @SerialName("allowed_card_networks")
        val allowedCardNetworks: Set<GooglePayCardNetworkEnum>
)