import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

/// {@macro currency}
@immutable
class Currency extends Equatable {
  /// {@template currency}
  /// Валюта платежа
  /// {@currency}
  const Currency({
    required this.value,
  });

  /// Значение
  final String value;

  /// ₽ - Российский рубль
  const Currency.rub() : value = 'RUB';

  /// $ - Американский доллар
  const Currency.usd() : value = 'USD';

  /// € - Евро
  const Currency.eur() : value = 'EUR';

  Map<String?, Object?> toJson() => <String, Object?>{
        'value': value,
      };

  @override
  String toString() => 'Currency(value: $value)';

  @override
  List<Object?> get props => [value];
}
