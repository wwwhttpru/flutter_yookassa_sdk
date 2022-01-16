import 'package:equatable/equatable.dart';
import 'package:flutter_yookassa_sdk/src/models/customization/customization.dart';
import 'package:flutter_yookassa_sdk/src/models/misc/misc.dart';
import 'package:meta/meta.dart';

/// {@macro tokenization_module_input_data}
@immutable
class TokenizationModuleInputData extends Equatable {
  /// {@template tokenization_module_input_data}
  /// Входные данные для потока токенизации.
  /// {@endtemplate}
  const TokenizationModuleInputData({
    required this.clientApplicationKey,
    required this.shopName,
    required this.purchaseDescription,
    required this.amount,
    required this.savePaymentMethod,
    required this.shopId,
    this.tokenizationSettings = const TokenizationSettings(),
    this.testModeSettings,
    this.isLoggingEnabled = false,
    this.customizationSettings = const CustomizationSettings(),
    this.gatewayId,
    this.moneyAuthClientId,
    this.applicationScheme,
    this.applePayMerchantIdentifier,
    this.userPhoneNumber,
    this.googlePayParameters = const GooglePayParameters(),
    this.customerId,
    this.isSafeDeal = false,
  });

  /// Ключ для клиентских приложений из личного кабинета ЮKassa
  final String clientApplicationKey;

  /// Название магазина в форме оплаты (title)
  final String shopName;

  /// Описание заказа в форме оплаты (subtitle)
  final String purchaseDescription;

  /// {@macro amount}
  final Amount amount;

  /// {@macro save_payment_method}
  final SavePaymentMethod savePaymentMethod;

  /// Идентификатор магазина в ЮKassa
  final String shopId;

  /// По умолчанию null.
  /// {@macro test_mode_settings}
  final TestModeSettings? testModeSettings;

  /// По умолчанию false.
  /// Включает логирование сетевых запросов.
  final bool isLoggingEnabled;

  /// {@macro customization_settings}
  final CustomizationSettings customizationSettings;

  /// По умолчанию null. Используется, если у вас
  /// несколько платежных шлюзов с разными идентификаторами.
  final String? gatewayId;

  /// По умолчанию используется стандартный инициализатор
  /// со всеми способами оплаты.
  /// {@macro tokenization_settings}
  final TokenizationSettings tokenizationSettings;

  /// По умолчанию null.
  /// Apple Pay merchant ID (обязательно для платежей через Apple Pay).
  final String? applePayMerchantIdentifier;

  /// По умолчанию null. Телефонный номер пользователя.
  final String? userPhoneNumber;

  /// По умолчанию null.
  /// Идентификатор для центра авторизации в системе YooMoney.
  ///
  /// Android(authCenterClientId)
  final String? moneyAuthClientId;

  /// По умолчанию null. Схема для возврата в приложение после
  /// успешной оплаты с помощью Sberpay в приложении СберБанк Онлайн
  /// или после успешной авторизации в YooMoney через мобильное приложение.
  final String? applicationScheme;

  /// {@macro google_pay_parameters}
  final GooglePayParameters googlePayParameters;

  /// Уникальный идентификатор покупателя в вашей системе,
  /// например электронная почта или номер телефона.
  /// Не более 200 символов. Используется, если вы хотите запомнить
  /// банковскую карту и отобразить ее при повторном платеже в mSdk"
  // TODO: (wwwhttpru) в данный момент рабоотает только в Android,
  // имеется проблема, на ios.
  // https://github.com/wwwhttpru/flutter_yookassa_sdk/issues/1
  @experimental
  final String? customerId;

  /// * iOS Является ли этот магазин безопасным магазином?
  // TODO: (wwwhttpru) https://github.com/wwwhttpru/flutter_yookassa_sdk/issues/1
  @experimental
  final bool isSafeDeal;

  Map<String, Object?> toJson() => <String, Object?>{
        'clientApplicationKey': clientApplicationKey,
        'shopName': shopName,
        'purchaseDescription': purchaseDescription,
        'amount': amount.toJson(),
        'savePaymentMethod': SavePaymentMethodModel.encode(savePaymentMethod),
        'testModeSettings': testModeSettings?.toJson(),
        'isLoggingEnabled': isLoggingEnabled,
        'customizationSettings': customizationSettings.toJson(),
        'gatewayId': gatewayId,
        'tokenizationSettings': tokenizationSettings.toJson(),
        'applePayMerchantIdentifier': applePayMerchantIdentifier,
        'userPhoneNumber': userPhoneNumber,
        'moneyAuthClientId': moneyAuthClientId,
        'applicationScheme': applicationScheme,
        'shopId': shopId,
        'googlePayParameters': googlePayParameters.toJson(),
        'customerId': customerId,
        'isSafeDeal': isSafeDeal,
      };

  @override
  String toString() => 'TokenizationModuleInputData('
      'clientApplicationKey: $clientApplicationKey\n'
      'shopName:$shopName\n'
      'purchaseDescription: $purchaseDescription\n'
      'tokenizationSettings: $tokenizationSettings\n'
      'amount: $amount\n'
      'savePaymentMethod: $savePaymentMethod\n'
      'testModeSettings: $testModeSettings\n'
      'isLoggingEnabled: $isLoggingEnabled\n'
      'customizationSettings: $customizationSettings\n'
      'moneyAuthClientId: $moneyAuthClientId\n'
      'applicationScheme: $applicationScheme\n'
      'applePayMerchantIdentifier: $applePayMerchantIdentifier\n'
      'userPhoneNumber: $userPhoneNumber\n'
      'gatewayId: $gatewayId\n'
      'shopId: $shopId\n'
      'googlePayParameters: $googlePayParameters\n'
      'customerId: $customerId\n'
      'isSafeDeal: $isSafeDeal)';

  @override
  List<Object?> get props => [
        clientApplicationKey,
        shopName,
        purchaseDescription,
        tokenizationSettings.props,
        amount.props,
        savePaymentMethod,
        testModeSettings?.props,
        isLoggingEnabled,
        customizationSettings.props,
        gatewayId,
        moneyAuthClientId,
        applicationScheme,
        applePayMerchantIdentifier,
        userPhoneNumber,
        shopId,
        googlePayParameters.props,
        customerId,
        isSafeDeal,
      ];
}
