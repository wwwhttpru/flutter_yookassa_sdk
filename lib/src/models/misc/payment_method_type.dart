import 'package:flutter_yookassa_sdk/src/models/help/help.dart';
import 'package:meta/meta.dart';

/// {@template payment_method_type}
/// Тип платежного средства.
/// {@endtemplate}
enum PaymentMethodType {
  /// Bank Card. "bank_card"
  bankCard,

  /// Sberbank.
  sberbank,

  /// ApplePay. "apple_pay"
  applePay,

  /// GooglePlay. "google_pay"
  googlePay,

  /// YooMoney. "yoo_money"
  yooMoney,
}

// ignore: avoid_classes_with_only_static_members
@internal
@immutable
class PaymentMethodTypeModel {
  static PaymentMethodType decode(Object? source) =>
      enumDecode<PaymentMethodType, String>(
        paymentMethodTypeEnumMap,
        source,
      );

  static String encode(PaymentMethodType source) {
    final value = paymentMethodTypeEnumMap[source];
    if (value == null) {
      throw ArgumentError(
        '`$source` is not one of the supported values: '
        '${paymentMethodTypeEnumMap.values.join(', ')}',
      );
    }
    return value;
  }

  static const Map<PaymentMethodType, String> paymentMethodTypeEnumMap = {
    PaymentMethodType.bankCard: 'bank_card',
    PaymentMethodType.sberbank: 'sberbank',
    PaymentMethodType.applePay: 'apple_pay',
    PaymentMethodType.googlePay: 'google_pay',
    PaymentMethodType.yooMoney: 'yoo_money',
  };
}
