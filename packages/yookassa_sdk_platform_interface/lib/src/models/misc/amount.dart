part of '../models.dart';

/// {@macro amount}
class Amount {
  /// {@template amount}
  /// Объект, содержащий сумму заказа и валюту
  /// {@endtemplate}
  const Amount({
    required this.value,
    required this.currency,
  });

  /// Сумма платежа
  final double value;

  /// {@macro currency}
  final Currency currency;

  /// Convert to JSON
  Map<String, Object?> toJson() => <String, Object?>{
        'value': value,
        'currency': currency.toJson(),
      };
}
