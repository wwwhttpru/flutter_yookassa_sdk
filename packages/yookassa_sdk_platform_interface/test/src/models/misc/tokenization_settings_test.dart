import 'package:flutter_test/flutter_test.dart';
import 'package:yookassa_sdk_platform_interface/src/models/models.dart';

void main() {
  late final TokenizationSettings tokenizationSettings;

  setUpAll(() {
    tokenizationSettings = const TokenizationSettings();
  });

  test('Default values from constructors', () {
    expect(
      tokenizationSettings.paymentMethodTypes,
      const PaymentMethodTypes.all(),
    );
  });

  test('toJson', () {
    expect(tokenizationSettings.toJson(), <String, Object?>{
      'payment_method_types': const PaymentMethodTypes.all().toJson(),
    });
  });
}
