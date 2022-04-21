part of '../models.dart';

/// {@macro payment_data}
@immutable
class PaymentData {
  /// {@template payment_data}
  /// Результат оплаты ЮКасса.
  ///
  /// [token] - Токен платежа.
  /// [paymentMethod] - Метод оплаты, см. [PaymentMethodType].
  /// {@endtemplate}
  const PaymentData({
    required this.token,
    required this.paymentMethod,
  });

  /// Converts the supplied [Map] to an instance of the [PaymentData] class.
  factory PaymentData.fromJson(Map<String, Object?> json) {
    if (!json.containsKey('token')) {
      throw ArgumentError.value(
        json,
        'token',
        "The supplied map doesn't contain the mandatory key `token`.",
      );
    }
    if (!json.containsKey('payment_method')) {
      throw ArgumentError.value(
        json,
        'payment_method',
        "The supplied map doesn't contain the mandatory key `payment_method`.",
      );
    }
    final String token = json['token'] as String;
    final String paymentMethod = json['payment_method'] as String;
    return PaymentData(
      token: token,
      paymentMethod: PaymentMethodTypeMixin.fromJson(paymentMethod),
    );
  }

  /// Токен оплаты.
  /// Создайте платеж по API ЮКасса
  final String token;

  /// Тип платежного средства
  final PaymentMethodType paymentMethod;

  /// Convert to JSON
  Map<String, Object?> toJson() => <String, Object?>{
        'token': token,
        'payment_method': paymentMethod.toJson,
      };

  @override
  String toString() =>
      'PaymentData(token: $token, paymentMethod: $paymentMethod)';

  @override
  int get hashCode => token.hashCode ^ paymentMethod.hashCode;

  @override
  bool operator ==(Object? other) =>
      identical(this, other) ||
      other is PaymentData &&
          runtimeType == other.runtimeType &&
          token == other.token &&
          paymentMethod == other.paymentMethod;
}
