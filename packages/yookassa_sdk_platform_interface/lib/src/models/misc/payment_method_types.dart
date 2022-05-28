part of '../models.dart';

/// {@macro payment_method_types}
class PaymentMethodTypes {
  /// {@template payment_method_types}
  /// Способы оплаты, доступные пользователю в приложении.
  /// {@endtemplate}
  const PaymentMethodTypes({
    required this.rawValue,
  });

  /// Any Bank card.
  const PaymentMethodTypes.bankCard()
      : rawValue = const <PaymentMethodType>{
          PaymentMethodType.bankCard,
        };

  /// YooMoney Wallet.
  const PaymentMethodTypes.yooMoney()
      : rawValue = const <PaymentMethodType>{
          PaymentMethodType.yooMoney,
        };

  /// Sberbank Online
  const PaymentMethodTypes.sberbank()
      : rawValue = const <PaymentMethodType>{
          PaymentMethodType.sberbank,
        };

  /// Apple Pay
  const PaymentMethodTypes.applePay()
      : rawValue = const <PaymentMethodType>{
          PaymentMethodType.applePay,
        };

  /// Google Pay
  const PaymentMethodTypes.googlePay()
      : rawValue = const <PaymentMethodType>{
          PaymentMethodType.googlePay,
        };

  /// All the available methods.
  const PaymentMethodTypes.all()
      : rawValue = const <PaymentMethodType>{
          PaymentMethodType.bankCard,
          PaymentMethodType.sberbank,
          PaymentMethodType.applePay,
          PaymentMethodType.googlePay,
          PaymentMethodType.yooMoney,
        };

  /// Платежные типы [PaymentMethodType],
  /// через которые возможна оплата в ЮКассе
  final Set<PaymentMethodType> rawValue;

  /// Convert to JSON
  Map<String, Object?> toJson() => <String, Object?>{
        'raw_value': rawValue
            .map((PaymentMethodType e) => e.toJson)
            .toList(growable: false),
      };
}
