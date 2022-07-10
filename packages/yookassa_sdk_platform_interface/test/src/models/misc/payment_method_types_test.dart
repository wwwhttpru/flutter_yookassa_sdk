import 'package:flutter_test/flutter_test.dart';
import 'package:yookassa_sdk_platform_interface/src/models/models.dart';

void main() {
  late final PaymentMethodTypes paymentMethodTypes;

  setUpAll(() {
    paymentMethodTypes = PaymentMethodTypes(
      rawValue: PaymentMethodType.values.toSet(),
    );
  });

  /// Correct set values
  test('Raw values is correct set', () {
    expect(paymentMethodTypes.rawValue, PaymentMethodType.values.toSet());
  });

  group('Named constructors', () {
    /// BankCard constructor
    test('BankCard constructor', () {
      const PaymentMethodTypes paymentMethodTypes =
          PaymentMethodTypes.bankCard();
      final Set<PaymentMethodType> actual = paymentMethodTypes.rawValue;
      const Set<PaymentMethodType> matcher = <PaymentMethodType>{
        PaymentMethodType.bankCard
      };
      expect(actual, matcher);
    });

    /// YooMoney constructor
    test('YooMoney constructor', () {
      const PaymentMethodTypes paymentMethodTypes =
          PaymentMethodTypes.yooMoney();
      final Set<PaymentMethodType> actual = paymentMethodTypes.rawValue;
      const Set<PaymentMethodType> matcher = <PaymentMethodType>{
        PaymentMethodType.yooMoney
      };
      expect(actual, matcher);
    });

    /// Sberbank constructor
    test('Sberbank constructor', () {
      const PaymentMethodTypes paymentMethodTypes =
          PaymentMethodTypes.sberbank();
      final Set<PaymentMethodType> actual = paymentMethodTypes.rawValue;
      const Set<PaymentMethodType> matcher = <PaymentMethodType>{
        PaymentMethodType.sberbank
      };
      expect(actual, matcher);
    });

    /// ApplePay constructor
    test('ApplePay constructor', () {
      const PaymentMethodTypes paymentMethodTypes =
          PaymentMethodTypes.applePay();
      final Set<PaymentMethodType> actual = paymentMethodTypes.rawValue;
      const Set<PaymentMethodType> matcher = <PaymentMethodType>{
        PaymentMethodType.applePay
      };
      expect(actual, matcher);
    });

    /// GooglePay constructor
    test('GooglePay constructor', () {
      const PaymentMethodTypes paymentMethodTypes =
          PaymentMethodTypes.googlePay();
      final Set<PaymentMethodType> actual = paymentMethodTypes.rawValue;
      const Set<PaymentMethodType> matcher = <PaymentMethodType>{
        PaymentMethodType.googlePay
      };
      expect(actual, matcher);
    });

    /// All constructor
    test('All constructor', () {
      const PaymentMethodTypes paymentMethodTypes = PaymentMethodTypes.all();
      final Set<PaymentMethodType> actual = paymentMethodTypes.rawValue;
      const Set<PaymentMethodType> matcher = <PaymentMethodType>{
        PaymentMethodType.bankCard,
        PaymentMethodType.yooMoney,
        PaymentMethodType.sberbank,
        PaymentMethodType.applePay,
        PaymentMethodType.googlePay
      };
      expect(actual, matcher);
    });
  });

  /// Convert to JSON
  test('Convert to JSON', () {
    final Map<String, Object?> actual = paymentMethodTypes.toJson();
    final Map<String, Object?> matcher = <String, Object?>{
      'raw_value': PaymentMethodType.values
          .map((PaymentMethodType e) => e.toJson)
          .toList(growable: false),
    };
    expect(actual, matcher);
  });
}
