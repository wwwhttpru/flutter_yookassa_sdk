part of '../models.dart';

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

/// PaymentMethodType extension
extension PaymentMethodTypeExtension on PaymentMethodType {
  /// Mapped this model to JSON name
  String get toJson {
    switch (this) {
      case PaymentMethodType.bankCard:
        return 'bank_card';
      case PaymentMethodType.sberbank:
        return 'sberbank';
      case PaymentMethodType.applePay:
        return 'apple_pay';
      case PaymentMethodType.googlePay:
        return 'google_pay';
      case PaymentMethodType.yooMoney:
        return 'yoo_money';
    }
  }
}

/// PaymentMethodType from JSON
@internal
mixin PaymentMethodTypeMixin {
  /// PaymentMethodType from JSON
  static PaymentMethodType fromJson(String value) {
    switch (value) {
      case 'bank_card':
        return PaymentMethodType.bankCard;
      case 'sberbank':
        return PaymentMethodType.sberbank;
      case 'apple_pay':
        return PaymentMethodType.applePay;
      case 'google_pay':
        return PaymentMethodType.googlePay;
      case 'yoo_money':
        return PaymentMethodType.yooMoney;
    }
    throw Exception('Unknown PaymentMethodType: $value');
  }
}
