part of '../models.dart';

/// {@macro currency}
class Currency {
  /// {@template currency}
  /// Валюта платежа.
  ///
  /// Можете выбрать одну из стандартных:
  /// [Currency.rub], [Currency.usd], [Currency.eur].
  ///
  /// Если вы хотите указать собственную валюту, создайте объект
  /// указав свою.
  /// {@endtemplate}
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

  /// Конвертировать объект в JSON-формат.
  Map<String, Object?> toJson() => <String, Object?>{'value': value};
}
