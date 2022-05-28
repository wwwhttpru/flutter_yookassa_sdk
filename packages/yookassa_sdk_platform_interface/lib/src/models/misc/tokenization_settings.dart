part of '../models.dart';

/// {@macro tokenization_settings}
class TokenizationSettings {
  /// {@template tokenization_settings}
  /// Настройки для токенизации.
  ///
  /// Вы можете определить какие способы оплаты будут доступны пользователю.
  /// По умолчанию доступны все способы оплаты.
  /// {@endtemplate}
  const TokenizationSettings({
    this.paymentMethodTypes = const PaymentMethodTypes.all(),
  });

  /// {@macro payment_method_types}
  final PaymentMethodTypes paymentMethodTypes;

  /// Конвертировать объект в JSON-формат.
  Map<String, Object?> toJson() => <String, Object?>{
        'payment_method_types': paymentMethodTypes.toJson(),
      };
}
