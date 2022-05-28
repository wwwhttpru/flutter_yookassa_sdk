part of '../models.dart';

/// {@template payment_method_type}
/// Тип платежного средства.
/// {@endtemplate}
enum PaymentMethodType {
  /// Банковская карта.
  bankCard,

  /// Сбербанк.
  sberbank,

  /// Apple Pay.
  ///
  /// Только в iOS.
  /// Если вы передадите это значение в метод платежа в Android,
  /// то система воспримет это как Google Pay.
  applePay,

  /// GooglePlay.
  ///
  /// Только в Android.
  /// Если вы передадите это значение в метод платежа в iOS,
  /// то система воспримет это как Apple Pay.
  googlePay,

  /// YooMoney.
  ///
  /// При использование данной системы вы должны зарегистрировать
  /// приложение и получить ключ.
  yooMoney,
}

/// Расширение для [PaymentMethodType].
extension PaymentMethodTypeExtension on PaymentMethodType {
  /// Конвертировать объект в строку, для использования в JSON-формате.
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

/// Класс для конвертирование строки в [PaymentMethodType].
@internal
mixin PaymentMethodTypeMixin {
  /// Конвертировать строку в [PaymentMethodType].
  ///
  /// Если строка не соответствует ни одному из вариантов,
  /// то выбросит [Exception].
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
