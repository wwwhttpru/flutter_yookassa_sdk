part of '../models.dart';

/// {@macro tokenization_settings}
class TokenizationSettings {
  /// {@template tokenization_settings}
  /// Можно настроить список способов оплаты.
  /// {@endtemplate}
  const TokenizationSettings({
    this.paymentMethodTypes = const PaymentMethodTypes.all(),
  });

  /// По умолчанию [PaymentMethodTypes.all].
  /// {@macro payment_method_types}
  final PaymentMethodTypes paymentMethodTypes;

  /// Convert to JSON
  Map<String, Object?> toJson() => <String, Object?>{
        'payment_method_types': paymentMethodTypes.toJson(),
      };
}
