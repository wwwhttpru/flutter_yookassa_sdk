package ru.wwwhttpru.yookassa_sdk_android

import android.app.Activity
import android.content.Intent
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.PluginRegistry
import ru.yoomoney.sdk.kassa.payments.Checkout
import ru.yoomoney.sdk.kassa.payments.TokenizationResult
import ru.yoomoney.sdk.kassa.payments.checkoutParameters.*
import ru.yoomoney.sdk.kassa.payments.ui.color.ColorScheme

open class FlutterYookassa : ActivityAware, PluginRegistry.ActivityResultListener {
    private var binding: ActivityPluginBinding? = null
    private var callback: TokenizationResultCallback? = null

    // Maybe delete?
    private fun checkBinding(resultCallback: TokenizationResultCallback): Boolean {
        if (binding?.activity?.application == null) {
            resultCallback.failure(
                    INVALID_APP_CODE,
                    "Fail to resolve Application on registration",
                    null
            )
            return false
        }
        return true
    }

    fun createTokenizeIntent(
            paymentParameters: PaymentParameters,
            testParameters: TestParameters = TestParameters(),
            uiParameters: UiParameters = UiParameters(),
            resultCallback: TokenizationResultCallback,
    ) {
        if (!checkBinding(resultCallback)) return
        callback = resultCallback
        binding?.let {
            val intent: Intent = Checkout.createTokenizeIntent(
                    it.activity,
                    paymentParameters = paymentParameters,
                    testParameters = testParameters,
                    uiParameters = uiParameters,
            )
            it.activity.startActivityForResult(intent, REQUEST_TOKENIZE_CODE)
        }
    }

    fun createSavedCardTokenizeIntent(
            savedBankCardPaymentParameters: SavedBankCardPaymentParameters,
            testParameters: TestParameters = TestParameters(),
            uiParameters: UiParameters = UiParameters(),
            resultCallback: TokenizationResultCallback,
    ) {
        if (!checkBinding(resultCallback)) return
        callback = resultCallback
        binding?.let {
            val intent: Intent = Checkout.createSavedCardTokenizeIntent(
                    it.activity,
                    savedBankCardPaymentParameters = savedBankCardPaymentParameters,
                    testParameters = testParameters,
                    uiParameters = uiParameters,
            )
            it.activity.startActivityForResult(intent, REQUEST_TOKENIZE_CODE)
        }
    }

    fun createConfirmationIntent(
            confirmationUrl: String,
            paymentMethodType: PaymentMethodType,
            colorScheme: ColorScheme = ColorScheme.getDefaultScheme(),
            testParameters: TestParameters = TestParameters(),
            resultCallback: TokenizationResultCallback,
    ) {
        if (!checkBinding(resultCallback)) return
        callback = resultCallback
        binding?.let {
            val intent: Intent = Checkout.createConfirmationIntent(
                    it.activity,
                    confirmationUrl = confirmationUrl,
                    paymentMethodType = paymentMethodType,
                    colorScheme = colorScheme,
                    testParameters = testParameters,
            )
            it.activity.startActivityForResult(intent, REQUEST_CONFIRM_CODE)
        }
    }


    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
        when (requestCode) {
            /// Tokenization
            REQUEST_TOKENIZE_CODE -> {
                when (resultCode) {
                    /// Успешно
                    Activity.RESULT_OK -> {
                        // Ok
                        if (data != null) {
                            callback?.success(Checkout.createTokenizationResult(data))
                        } else {
                            callback?.failure(
                                    INVALID_TOKENIZATION_CODE,
                                    "An unknown error has occurred",
                                    null,
                            )
                        }
                    }
                    Activity.RESULT_CANCELED -> {
                        // Экран 3ds был закрыт
                        callback?.failure(
                                CANCELED_CODE,
                                "Payment has been cancelled by user",
                                null,
                        )
                    }
                    Checkout.RESULT_ERROR -> {
                        // Во время 3ds произошла какая-то ошибка (нет соединения или что-то еще)
                        // Более подробную информацию можно посмотреть в data
                        // data.getIntExtra(Checkout.EXTRA_ERROR_CODE) - код ошибки из WebViewClient.ERROR_* или Checkout.ERROR_NOT_HTTPS_URL
                        val errorCode = data?.getStringExtra(Checkout.EXTRA_ERROR_DESCRIPTION)
                        // data.getStringExtra(Checkout.EXTRA_ERROR_DESCRIPTION) - описание ошибки (может отсутствовать)
                        val message = data?.getStringExtra(Checkout.EXTRA_ERROR_DESCRIPTION)
                        // data.getStringExtra(Checkout.EXTRA_ERROR_FAILING_URL) - url по которому произошла ошибка (может отсутствовать)
                        val detail = data?.getStringExtra(Checkout.EXTRA_ERROR_FAILING_URL)
                        callback?.failure(
                                INVALID_TOKENIZATION_CODE,
                                message,
                                "Code: $errorCode, detail: $detail"
                        )
                    }
                    else -> {
                        callback?.failure(
                                INVALID_TOKENIZATION_CODE,
                                "An unknown error has occurred",
                                null,
                        )
                        callback = null
                        return false
                    }
                }
            }
            REQUEST_CONFIRM_CODE -> {
                when (resultCode) {
                    /// Успешно
                    Activity.RESULT_OK -> {
                        // Процесс 3ds завершён, нет информации о том, завершился процесс с успехом или нет
                        // Рекомендуется запросить статус платежа
                        callback?.success(null)
                    }
                    Activity.RESULT_CANCELED -> {
                        // Экран 3ds был закрыт
                        callback?.failure(
                                CANCELED_CODE,
                                "Payment has been cancelled by user",
                                null,
                        )
                    }
                    Checkout.RESULT_ERROR -> {
                        // Во время 3ds произошла какая-то ошибка (нет соединения или что-то еще)
                        // Более подробную информацию можно посмотреть в data
                        // data.getIntExtra(Checkout.EXTRA_ERROR_CODE) - код ошибки из WebViewClient.ERROR_* или Checkout.ERROR_NOT_HTTPS_URL
                        val errorCode = data?.getStringExtra(Checkout.EXTRA_ERROR_DESCRIPTION)
                        // data.getStringExtra(Checkout.EXTRA_ERROR_DESCRIPTION) - описание ошибки (может отсутствовать)
                        val message = data?.getStringExtra(Checkout.EXTRA_ERROR_DESCRIPTION)
                        // data.getStringExtra(Checkout.EXTRA_ERROR_FAILING_URL) - url по которому произошла ошибка (может отсутствовать)
                        val detail = data?.getStringExtra(Checkout.EXTRA_ERROR_FAILING_URL)
                        callback?.failure(
                                INVALID_CONFIRMATION_CODE,
                                "An error has occurred",
                                "Code: $errorCode, message: $message, detail: $detail"
                        )
                    }
                    else -> {
                        callback?.failure(
                                INVALID_CONFIRMATION_CODE,
                                "An unknown error has occurred",
                                null,
                        )
                        callback = null
                        return false
                    }
                }
            }
        }
        callback = null
        return true
    }


    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        this.binding = binding
        binding.addActivityResultListener(this)
    }

    override fun onDetachedFromActivityForConfigChanges() {
        binding?.removeActivityResultListener(this)
        binding = null
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        this.binding?.removeActivityResultListener(this)
        this.binding = binding
        binding.addActivityResultListener(this)
    }

    override fun onDetachedFromActivity() {
        binding?.removeActivityResultListener(this)
        binding = null
    }

}

interface TokenizationResultCallback {
    fun success(tokenizationResult: TokenizationResult?)
    fun failure(errorCode: String, message: String?, detail: String?)
}