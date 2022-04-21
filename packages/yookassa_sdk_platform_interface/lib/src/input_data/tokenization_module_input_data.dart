part of '../models/models.dart';

/// {@macro tokenization_module_input_data}
class TokenizationModuleInputData extends BaseModuleInputData {
  /// {@template tokenization_module_input_data}
  /// Входные данные для потока токенизации.
  /// {@endtemplate}
  const TokenizationModuleInputData({
    required Amount amount,
    required String shopName,
    required String purchaseDescription,
    required String clientApplicationKey,
    required String shopId,
    required SavePaymentMethod savePaymentMethod,
    String? gatewayId,
    bool isLoggingEnabled = false,
    TestModeSettings? testModeSettings,
    CustomizationSettings customizationSettings = const CustomizationSettings(),
    this.tokenizationSettings = const TokenizationSettings(),
    this.customReturnUrl,
    this.moneyAuthClientId,
    this.applicationScheme,
    this.applePayMerchantIdentifier,
    this.userPhoneNumber,
    this.googlePayParameters = const GooglePayParameters(),
    this.customerId,
  }) : super(
          clientApplicationKey: clientApplicationKey,
          shopName: shopName,
          purchaseDescription: purchaseDescription,
          amount: amount,
          savePaymentMethod: savePaymentMethod,
          shopId: shopId,
          gatewayId: gatewayId,
          isLoggingEnabled: isLoggingEnabled,
          testModeSettings: testModeSettings,
          customizationSettings: customizationSettings,
        );

  /// По умолчанию используется стандартный инициализатор
  /// со всеми способами оплаты.
  /// {@macro tokenization_settings}
  final TokenizationSettings tokenizationSettings;

  /// {@macro google_pay_parameters}
  final GooglePayParameters googlePayParameters;

  /// По умолчанию null.
  /// Идентификатор для центра авторизации в системе YooMoney.
  final String? moneyAuthClientId;

  /// По умолчанию null. Телефонный номер пользователя.
  final String? userPhoneNumber;

  /// По умолчанию null. URL страницы (поддерживается только https), на которую
  /// надо вернуться после прохождения 3-D Secure.
  /// Необходим только при кастомной реализации 3-D Secure.
  /// Если вы используете TODO: confirm methodName,
  /// не задавайте этот параметр.
  final String? customReturnUrl;

  /// По умолчанию null.
  /// Apple Pay merchant ID (обязательно для платежей через Apple Pay).
  final String? applePayMerchantIdentifier;

  /// По умолчанию null. Схема для возврата в приложение после
  /// успешной оплаты с помощью Sberpay в приложении СберБанк Онлайн
  /// или после успешной авторизации в YooMoney через мобильное приложение.
  /// Используется только в iOS.
  final String? applicationScheme;

  /// уникальный идентификатор покупателя в вашей системе,
  /// например, электронная почта или номер телефона.
  /// Есть ограничение на длину - не более 200 символов.
  /// Убедитесь, что [customerId] относится к пользователю,
  /// который хочет совершить покупку.
  /// Например, используйте двухфакторную аутентификацию.
  /// *Если передать неверный идентификатор, пользователь сможет выбрать для оплаты чужие банковские карты.*
  final String? customerId;

  /// Convert to JSON
  @override
  Map<String, Object?> toJson() => <String, Object?>{
        ...super.toJson(),
        'tokenization_settings': tokenizationSettings.toJson(),
        'google_pay_parameters': googlePayParameters.toJson(),
        'money_auth_client_id': moneyAuthClientId,
        'user_phone_number': userPhoneNumber,
        'custom_return_url': customReturnUrl,
        'apple_pay_merchant_identifier': applePayMerchantIdentifier,
        'application_scheme': applicationScheme,
        'customer_id': customerId,
      };
}
