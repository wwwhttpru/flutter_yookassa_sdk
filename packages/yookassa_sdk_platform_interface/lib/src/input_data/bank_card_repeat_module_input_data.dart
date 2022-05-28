part of '../models/models.dart';

/// {@macro bank_card_repeat_module_input_data}
class BankCardRepeatModuleInputData extends BaseModuleInputData {
  /// {@template bank_card_repeat_module_input_data}
  /// Входные данные для повторной токенизации банковской карты.
  /// {@endtemplate}
  const BankCardRepeatModuleInputData({
    required Amount amount,
    required String shopName,
    required String purchaseDescription,
    required String clientApplicationKey,
    required String shopId,
    required SavePaymentMethod savePaymentMethod,
    required this.paymentMethodId,
    String? gatewayId,
    bool isLoggingEnabled = false,
    TestModeSettings? testModeSettings,
    CustomizationSettings customizationSettings = const CustomizationSettings(),
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

  /// Идентификатор сохраненного способа оплаты
  final String paymentMethodId;

  /// Конвертировать объект в JSON-формат.
  @override
  Map<String, Object?> toJson() => <String, Object?>{
        ...super.toJson(),
        'payment_method_id': paymentMethodId,
      };
}
