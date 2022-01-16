import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

/// {@macro payment_data}
@immutable
class PaymentData extends Equatable {
  /// {@template payment_data}
  /// Результат оплаты ЮКасса
  /// {@endtemplate}
  const PaymentData({
    required this.token,
    required this.paymentMethod,
  });

  /// Токен оплаты.
  /// Создайте платеж по API ЮКасса
  final String token;

  /// Тип платежного средства
  final String paymentMethod;

  Map<String, Object?> toJson() => <String, Object?>{
        'token': token,
        'paymentMethod': paymentMethod,
      };

  @override
  String toString() =>
      'PaymentData(token: $token, paymentMethod: $paymentMethod)';

  @override
  List<Object?> get props => [token, paymentMethod];
}

@internal
@immutable
class PaymentDataModel extends PaymentData {
  const PaymentDataModel({
    required String token,
    required String paymentMethod,
  }) : super(
          token: token,
          paymentMethod: paymentMethod,
        );

  factory PaymentDataModel.fromJson(Map<String, Object?> data) =>
      PaymentDataModel(
        token: data['token']! as String,
        paymentMethod: data['paymentMethod']! as String,
      );
}
