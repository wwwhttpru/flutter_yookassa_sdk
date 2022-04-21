import '../models/models.dart';

/// {@macro base_module_input_data}
abstract class BaseModuleInputData {
  /// {@template base_module_input_data}
  /// Базовый класс для всех модулей ввода данных.
  /// {@endtemplate}
  const BaseModuleInputData({
    required this.amount,
    required this.shopName,
    required this.purchaseDescription,
    required this.clientApplicationKey,
    required this.shopId,
    required this.savePaymentMethod,
    required this.gatewayId,
    this.isLoggingEnabled = false,
    this.testModeSettings,
    this.customizationSettings = const CustomizationSettings(),
  });

  /// {@macro amount}
  final Amount amount;

  /// Название магазина в форме оплаты.
  final String shopName;

  /// Описание заказа в форме оплаты
  final String purchaseDescription;

  /// Ключ для клиентских приложений из личного кабинета ЮKassa.
  final String clientApplicationKey;

  /// Идентификатор магазина в ЮKassa
  final String shopId;

  /// {@macro save_payment_method}
  final SavePaymentMethod savePaymentMethod;

  /// По умолчанию null. Используется, если у вас
  /// несколько платежных шлюзов с разными идентификаторами.
  final String? gatewayId;

  /// По умолчанию false.
  /// Включает логирование сетевых запросов.
  final bool isLoggingEnabled;

  /// По умолчанию null.
  /// {@macro test_mode_settings}
  final TestModeSettings? testModeSettings;

  /// {@macro customization_settings}
  final CustomizationSettings customizationSettings;

  /// Convert to JSON
  Map<String, Object?> toJson() => <String, Object?>{
        'amount': amount.toJson(),
        'shop_name': shopName,
        'purchase_description': purchaseDescription,
        'client_application_key': clientApplicationKey,
        'shop_id': shopId,
        'save_payment_method': savePaymentMethod.toJson,
        'gateway_id': gatewayId,
        'is_logging_enabled': isLoggingEnabled,
        'test_mode_settings': testModeSettings?.toJson(),
        'customization_settings': customizationSettings.toJson(),
      };
}
