import 'package:equatable/equatable.dart';
import 'package:flutter_yookassa_sdk/src/models/misc/currency.dart';
import 'package:meta/meta.dart';

/// {@macro amount}
@immutable
class Amount extends Equatable {
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

  /// To Map
  Map<String, Object?> toJson() => <String, Object?>{
        'value': value,
        'currency': currency.toJson(),
      };

  @override
  String toString() => 'Amount(value: $value, currency: $currency)';

  @override
  List<Object?> get props => [value, currency.props];
}
