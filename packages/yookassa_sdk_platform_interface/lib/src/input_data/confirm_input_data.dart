part of '../models/models.dart';

/// {@macro confirm_input_data}
class ConfirmInputData {
  /// {@template confirm_input_data}
  /// Входные данные для подтверждение токенизации.
  /// {@endtemplate}
  const ConfirmInputData({
    required this.confirmationUrl,
    required this.paymentMethodType,
    this.isLoggingEnabled = false,
    this.testModeSettings,
    this.customizationSettings = const CustomizationSettings(),
  });

  /// URL для перехода на 3DS.
  final String confirmationUrl;

  /// Выбранный тип платежного метода
  /// (тот, что был получен в методе YookassaSdkInterface.tokenization).
  ///
  /// {@macro payment_method_type}
  final PaymentMethodType paymentMethodType;

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
        'confirmation_url': confirmationUrl,
        'payment_method_type': paymentMethodType,
        'is_logging_enabled': isLoggingEnabled,
        'test_mode_settings': testModeSettings?.toJson(),
        'customization_settings': customizationSettings.toJson(),
      };
}
