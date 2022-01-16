import 'package:equatable/equatable.dart';
import 'package:flutter_yookassa_sdk/src/models/customization/customization.dart';
import 'package:flutter_yookassa_sdk/src/models/misc/misc.dart';
import 'package:meta/meta.dart';

/// {@macro bank_card_repeat_module_input_data}
@immutable
class BankCardRepeatModuleInputData extends Equatable {
  /// {@template bank_card_repeat_module_input_data}
  /// Входные данные для повторной токенизации банковской карты.
  /// {@endtemplate}
  const BankCardRepeatModuleInputData({
    required this.clientApplicationKey,
    required this.shopName,
    required this.purchaseDescription,
    required this.paymentMethodId,
    required this.amount,
    required this.savePaymentMethod,
    required this.shopId,
    this.showYooKassaLogo = true,
    this.testModeSettings,
    this.isLoggingEnabled = false,
    this.customizationSettings = const CustomizationSettings(),
    this.gatewayId,
  });

  /// Ключ для клиентских приложений из личного кабинета ЮKassa
  final String clientApplicationKey;

  /// Название магазина в форме оплаты
  final String shopName;

  /// Описание заказа в форме оплаты
  final String purchaseDescription;

  /// Идентификатор сохраненного способа оплаты
  final String paymentMethodId;

  /// {@macro amount}
  final Amount amount;

  /// {@macro save_payment_method}
  final SavePaymentMethod savePaymentMethod;

  /// Идентификатор магазина в ЮKassa
  final String shopId;

  /// По умолчанию true. Отвечает за отображение логотипа ЮKassa.
  /// По умолчанию логотип отображается.
  final bool showYooKassaLogo;

  // TODO: returnUrl

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

  Map<String, Object?> toJson() => <String, Object?>{
        'clientApplicationKey': clientApplicationKey,
        'shopName': shopName,
        'purchaseDescription': purchaseDescription,
        'paymentMethodId': paymentMethodId,
        'amount': amount.toJson(),
        'shopId': shopId,
        'showYooKassaLogo': showYooKassaLogo,
        'savePaymentMethod': SavePaymentMethodModel.encode(savePaymentMethod),
        'testModeSettings': testModeSettings?.toJson(),
        'isLoggingEnabled': isLoggingEnabled,
        'customizationSettings': customizationSettings.toJson(),
        'gatewayId': gatewayId,
      };

  @override
  String toString() => 'BankCardRepeatModuleInputData('
      'clientApplicationKey: $clientApplicationKey\n'
      'shopName:$shopName\n'
      'purchaseDescription: $purchaseDescription\n'
      'paymentMethodId: $paymentMethodId\n'
      'amount: $amount\n'
      'shopId: $shopId\n'
      'showYooKassaLogo: $showYooKassaLogo\n'
      'savePaymentMethod: $savePaymentMethod\n'
      'testModeSettings: $testModeSettings\n'
      'isLoggingEnabled: $isLoggingEnabled\n'
      'customizationSettings: $customizationSettings\n'
      'gatewayId: $gatewayId)';

  @override
  List<Object?> get props => [
        clientApplicationKey,
        shopName,
        purchaseDescription,
        paymentMethodId,
        amount.props,
        shopId,
        showYooKassaLogo,
        savePaymentMethod,
        testModeSettings,
        isLoggingEnabled,
        customizationSettings.props,
        gatewayId,
      ];
}
