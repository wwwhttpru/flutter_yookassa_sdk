import 'package:flutter_test/flutter_test.dart';
import 'package:yookassa_sdk_platform_interface/src/models/models.dart';

void main() {
  test('PaymentMethodType should contain 5 options', () {
    const List<PaymentMethodType> values = PaymentMethodType.values;

    expect(values.length, 5);
  });

  test('PaymentMethodType enum should have items in correct index', () {
    const List<PaymentMethodType> values = PaymentMethodType.values;

    expect(values[0], PaymentMethodType.bankCard);
    expect(values[1], PaymentMethodType.sberbank);
    expect(values[2], PaymentMethodType.applePay);
    expect(values[3], PaymentMethodType.googlePay);
    expect(values[4], PaymentMethodType.yooMoney);
  });

  test('PaymentMethodType should have correct values', () {
    const List<PaymentMethodType> values = PaymentMethodType.values;

    expect(values[0].toJson, 'bank_card');
    expect(values[1].toJson, 'sberbank');
    expect(values[2].toJson, 'apple_pay');
    expect(values[3].toJson, 'google_pay');
    expect(values[4].toJson, 'yoo_money');
  });

  test(
    'Convert string value to PaymentMethodType',
    () {
      const List<PaymentMethodType> values = PaymentMethodType.values;

      expect(PaymentMethodTypeMixin.fromJson('bank_card'), values[0]);
      expect(PaymentMethodTypeMixin.fromJson('sberbank'), values[1]);
      expect(PaymentMethodTypeMixin.fromJson('apple_pay'), values[2]);
      expect(PaymentMethodTypeMixin.fromJson('google_pay'), values[3]);
      expect(PaymentMethodTypeMixin.fromJson('yoo_money'), values[4]);
      expect(() => PaymentMethodTypeMixin.fromJson('value'), throwsException);
    },
  );
}
