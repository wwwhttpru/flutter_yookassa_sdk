part of '../models.dart';

/// {@macro currency}
class Currency {
  /// {@template currency}
  /// Валюта платежа
  /// {@currency}
  const Currency({
    required this.value,
  });

  /// ₽ - Российский рубль
  const Currency.rub() : value = 'RUB';

  /// $ - Американский доллар
  const Currency.usd() : value = 'USD';

  /// € - Евро
  const Currency.eur() : value = 'EUR';

  /// Значение
  final String value;

  /// Convert to JSON
  Map<String, Object?> toJson() => <String, Object?>{'value': value};
}
