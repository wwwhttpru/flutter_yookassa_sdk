import 'package:flutter_test/flutter_test.dart';
import 'package:yookassa_sdk_platform_interface/src/models/models.dart';

void main() {
  late final PaymentData paymentData;

  setUpAll(() {
    paymentData = const PaymentData(
      token: 'test_token',
      paymentMethod: PaymentMethodType.bankCard,
    );
  });

  /// Test convert from json
  test('fromJson', () {
    final PaymentData paymentDataFromJson = PaymentData.fromJson(
      const <String, Object?>{
        'token': 'test_token',
        'payment_method': 'bank_card',
      },
    );

    expect(paymentDataFromJson, paymentData);
  });

  /// Test convert to JSON
  test('Convert toJson', () {
    final Map<String, Object?> actual = <String, Object?>{
      'token': 'test_token',
      'payment_method': 'bank_card',
    };
    final Map<String, Object?> expected = paymentData.toJson();
    expect(actual, expected);
  });
}
