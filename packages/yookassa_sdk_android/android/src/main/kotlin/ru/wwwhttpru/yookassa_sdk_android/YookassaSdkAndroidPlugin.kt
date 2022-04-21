package ru.wwwhttpru.yookassa_sdk_android

import android.util.Log
import androidx.annotation.NonNull
import androidx.annotation.Nullable
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import kotlinx.serialization.SerializationException
import kotlinx.serialization.json.Json
import ru.yoomoney.sdk.kassa.payments.TokenizationResult
import ru.yoomoney.sdk.kassa.payments.checkoutParameters.PaymentParameters
import ru.yoomoney.sdk.kassa.payments.checkoutParameters.SavedBankCardPaymentParameters

/** YookassaSdkAndroidPlugin */
class YookassaSdkAndroidPlugin : FlutterPlugin, MethodCallHandler, FlutterYookassa() {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private lateinit var activeResult: Result

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, CHANNEL)
        channel.setMethodCallHandler(this)
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        // Set result
        activeResult = result

        val arguments = call.arguments as Map<*, *>?
        if (arguments == null && (call.method == PAYMENT_TOKENIZATION || call.method == CARD_TOKENIZATION || call.method == CONFIRMATION)) {
            invokeErrorResult(INVALID_PARAMETERS_CODE, "Invalid parameters. \"Arguments\" is null", null)
            return
        }

        when (call.method) {
            PAYMENT_TOKENIZATION -> paymentTokenization(arguments!!)
            CARD_TOKENIZATION -> cardTokenization(arguments!!)
            CONFIRMATION -> confirmation(arguments!!)
            else -> invokeErrorResult(NOT_IMPLEMENTED_CODE, "Method not implemented ${call.method}", null)
        }
    }

    private fun paymentTokenization(@NonNull arguments: Map<*, *>) {
        val inputDataModel: TokenizationModuleInputDataModel?
        try {
            val json = Json { ignoreUnknownKeys = true }
            inputDataModel = json.decodeFromJsonElement(
                    TokenizationModuleInputDataModel.serializer(),
                    arguments.toJsonElement()
            )
        } catch (e: SerializationException) {
            invokeErrorResult(INVALID_CONVERTER_CODE, "Failed to convert data for tokenization", e.message)
            return
        }
        createTokenizeIntent(
                paymentParameters = PaymentParameters(
                        amount = convertAmount(inputDataModel.amount),
                        title = inputDataModel.shopName,
                        subtitle = inputDataModel.purchaseDescription,
                        clientApplicationKey = inputDataModel.clientApplicationKey,
                        shopId = inputDataModel.shopId,
                        savePaymentMethod = inputDataModel.savePaymentMethod.toSavePaymentMethod(),
                        paymentMethodTypes = convertPaymentMethodTypes(inputDataModel.tokenizationSettings),
                        gatewayId = inputDataModel.gatewayId,
                        customReturnUrl = inputDataModel.customReturnUrl,
                        userPhoneNumber = inputDataModel.userPhoneNumber,
                        googlePayParameters = convertGooglePayParameters(inputDataModel.googlePayParameters),
                        authCenterClientId = inputDataModel.moneyAuthClientId,
                        customerId = inputDataModel.customerId,
                ),
                testParameters = convertTestParameters(
                        testModeSettings = inputDataModel.testModeSettings,
                        showLogs = inputDataModel.isLoggingEnabled,
                ),
                uiParameters = convertUiParameters(settings = inputDataModel.customizationSettings),
                resultCallback = fetchTokenizationResultHandler(),
        )
    }

    private fun cardTokenization(@NonNull arguments: Map<*, *>) {
        val inputDataModel: BankCardRepeatModuleInputDataModel?
        try {
            val json = Json { ignoreUnknownKeys = true }
            inputDataModel = json.decodeFromJsonElement(
                    BankCardRepeatModuleInputDataModel.serializer(),
                    arguments.toJsonElement()
            )
        } catch (e: SerializationException) {
            invokeErrorResult(INVALID_CONVERTER_CODE, "Failed to convert data for card tokenization", e.message)
            return
        }
        createSavedCardTokenizeIntent(
                savedBankCardPaymentParameters = SavedBankCardPaymentParameters(
                        amount = convertAmount(inputDataModel.amount),
                        title = inputDataModel.shopName,
                        subtitle = inputDataModel.purchaseDescription,
                        clientApplicationKey = inputDataModel.clientApplicationKey,
                        shopId = inputDataModel.shopId,
                        savePaymentMethod = inputDataModel.savePaymentMethod.toSavePaymentMethod(),
                        gatewayId = inputDataModel.gatewayId,
                        paymentMethodId = inputDataModel.paymentMethodId,
                ),
                testParameters = convertTestParameters(
                        testModeSettings = inputDataModel.testModeSettings,
                        showLogs = inputDataModel.isLoggingEnabled,
                ),
                uiParameters = convertUiParameters(settings = inputDataModel.customizationSettings),
                resultCallback = fetchTokenizationResultHandler(),
        )
    }

    private fun confirmation(@NonNull arguments: Map<*, *>) {
        val inputDataModel: ConfirmInputDataModel?
        try {
            val json = Json { ignoreUnknownKeys = true }
            inputDataModel = json.decodeFromJsonElement(
                    ConfirmInputDataModel.serializer(),
                    arguments.toJsonElement()
            )
        } catch (e: SerializationException) {
            invokeErrorResult(INVALID_CONVERTER_CODE, "Failed to convert data for confirmation", e.message)
            return
        }
        createConfirmationIntent(
                confirmationUrl = inputDataModel.confirmationUrl,
                paymentMethodType = inputDataModel.paymentMethodType.toPaymentMethodType(),
                testParameters = convertTestParameters(
                        testModeSettings = inputDataModel.testModeSettings,
                        showLogs = inputDataModel.isLoggingEnabled,
                ),
                colorScheme = convertUiParameters(
                        settings = inputDataModel.customizationSettings
                ).colorScheme,
                resultCallback = fetchTokenizationResultHandler(),
        )
    }

    private fun fetchTokenizationResultHandler(): TokenizationResultCallback {
        return object : TokenizationResultCallback {
            override fun success(tokenizationResult: TokenizationResult?) = ignoreIllegalState {
                activeResult.success(tokenizationResult?.toMap())
            }

            override fun failure(errorCode: String, message: String?, detail: String?) = invokeErrorResult(
                    errorCode = errorCode,
                    message = message,
                    detail = detail
            )
        }
    }

    private fun invokeErrorResult(
            @NonNull errorCode: String,
            @Nullable message: String?,
            @Nullable detail: String?,
    ) {
        ignoreIllegalState {
            activeResult.error(
                    errorCode,
                    message,
                    detail
            )
        }
    }

    private fun ignoreIllegalState(@NonNull fn: () -> Unit) {
        try {
            fn()
        } catch (e: IllegalStateException) {
            Log.d(
                    CHANNEL,
                    "ignoring exception: $e. See https://github.com/flutter/flutter/issues/29092 for details."
            )
        }
    }
}
