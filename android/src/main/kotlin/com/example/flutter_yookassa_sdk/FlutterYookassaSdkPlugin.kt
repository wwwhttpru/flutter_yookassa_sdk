package com.example.flutter_yookassa_sdk

import android.graphics.Color
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

import ru.yoomoney.sdk.kassa.payments.TokenizationResult
import ru.yoomoney.sdk.kassa.payments.checkoutParameters.*
import ru.yoomoney.sdk.kassa.payments.ui.color.ColorScheme
import java.util.*

/** FlutterYookassaSdkPlugin */
class FlutterYookassaSdkPlugin: FlutterPlugin, MethodCallHandler, FlutterYookassa() {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_yookassa_sdk")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
      when(call.method) {
          "tokenization" -> {
              val args = call.arguments as Map<String, Any>
              /// Amount
              val argsAmount = args["amount"] as Map<*, *>
              val amount = fetchAmount(argsAmount)
              /// title
              val title = args["shopName"] as String
              /// subtitle
              val subtitle = args["purchaseDescription"] as String
              /// clientApplicationKey
              val clientApplicationKey = args["clientApplicationKey"] as String
              /// shopId
              val shopId = args["shopId"] as String
              /// savePaymentMethod
              val savePaymentMethod = (args["savePaymentMethod"] as String).toSavePaymentMethod()
              /// authCenterClientId
              val authCenterClientId = args["moneyAuthClientId"] as String?
              val tokenizationSettingsArgs = args["tokenizationSettings"] as Map<*, *>
              val paymentMethodTypesArgs = tokenizationSettingsArgs["paymentMethodTypes"] as Map<*, *>?
              val paymentMethodTypesList = paymentMethodTypesArgs?.get("rawValue") as Iterable<String>
              val paymentMethodTypes = (paymentMethodTypesList.map {
                  it.toPaymentMethodType()
              }).toSet()
              /// showYookassaLogo
              val showLogo = tokenizationSettingsArgs["showYooKassaLogo"] as Boolean
              /// gatewayId
              val gatewayId = args["gatewayId"] as String?
              /// userPhoneNumber
              val userPhoneNumber = args["userPhoneNumber"] as String?
              /// googlePayParameters
              val googlePayParametersArgs = args["googlePayParameters"] as Map<*, *>?
              val allowedCardNetworksList = googlePayParametersArgs?.get("allowedCardNetworks") as Iterable<String>
              val allowedCardNetworks = (allowedCardNetworksList.map {
                  it.toGooglePayCardNetwork()
              }).toSet()
              val googlePayParameters = GooglePayParameters(
                      allowedCardNetworks = allowedCardNetworks
              )
              val customerId = args["customerId"] as String?
              val paymentParameters = PaymentParameters(
                      amount = amount,
                      title = title,
                      subtitle = subtitle,
                      clientApplicationKey = clientApplicationKey,
                      shopId = shopId,
                      savePaymentMethod = savePaymentMethod,
                      paymentMethodTypes = paymentMethodTypes,
                      gatewayId = gatewayId,
                      userPhoneNumber = userPhoneNumber,
                      googlePayParameters = googlePayParameters,
                      authCenterClientId = authCenterClientId,
                      customerId = customerId

              )
              val uiParameters = fetchUiParameters(args, showLogo)
              val testParameters = fetchTestParameters(args)
              startCheckout(
                      paymentParameters = paymentParameters,
                      resultCallback = fetchTokenizationResultHandler(result),
                      testParameters = testParameters,
                      uiParameters = uiParameters
              )
          }
          "bankCardRepeat" -> {
              val args = call.arguments as Map<String, Any>
              /// Amount
              val amount = fetchAmount(args["amount"] as Map<*, *>)
              /// title
              val title = args["shopName"] as String
              /// subtitle
              val subtitle = args["purchaseDescription"] as String
              /// clientApplicationKey
              val clientApplicationKey = args["clientApplicationKey"] as String
              /// shopId
              val shopId = args["shopId"] as String
              /// paymentMethodId
              val paymentMethodId = args["paymentMethodId"] as String
              /// savePaymentMethod
              val savePaymentMethod = (args["savePaymentMethod"] as String).toSavePaymentMethod()
              /// gatewayId
              val gatewayId = args["gatewayId"] as String?
              val bankCardRepeat = SavedBankCardPaymentParameters(
                      amount = amount,
                      title = title,
                      subtitle = subtitle,
                      clientApplicationKey = clientApplicationKey,
                      shopId = shopId,
                      paymentMethodId = paymentMethodId,
                      savePaymentMethod = savePaymentMethod,
                      gatewayId = gatewayId,

              )
              val testParameters = fetchTestParameters(args)
              val showLogo = args["showYooKassaLogo"] as Boolean
              val uiParameters = fetchUiParameters(args, showLogo)
              startCheckoutWithCvcRepeatRequest(
                      bankCardRepeat,
                      resultCallback = fetchTokenizationResultHandler(result),
                      testParameters = testParameters,
                      uiParameters = uiParameters
              )
          }
          "confirm3dsCheckout" -> {
              val args = call.arguments as Map<String, Any>
              /// confirmationUrl
              val confirmationUrl = args["confirmationUrl"] as String
              /// paymentMethodType
              val paymentMethodType = (args["paymentMethodType"] as String).toPaymentMethodType()

              confirm3dsCheckout(
                      confirmationUrl,
                      paymentMethodType,
                      fetchTokenizationResultHandler(result)
              )

          }
          else -> result.notImplemented()
      }
  }



  private fun fetchTokenizationResultHandler(result: Result): TokenizationResultCallback {
    return object : TokenizationResultCallback {
      override fun success(tokenizationResult: TokenizationResult?) = result.success(
              PaymentResult(success = true, paymentData = tokenizationResult).toMap()
      )

      override fun failure(error: String) = result.success(
              PaymentResult(success = false, error = error).toMap()
      )
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}