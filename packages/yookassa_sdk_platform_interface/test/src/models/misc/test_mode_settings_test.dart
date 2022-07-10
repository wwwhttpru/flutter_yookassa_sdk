import 'package:flutter_test/flutter_test.dart';
import 'package:yookassa_sdk_platform_interface/src/models/models.dart';

void main() {
  late final TestModeSettings testModeSettings;
  late final Amount charge;

  setUpAll(() {
    charge = const Amount(
      value: 100,
      currency: Currency.rub(),
    );
    testModeSettings = TestModeSettings(
      paymentAuthorizationPassed: true,
      enablePaymentError: false,
      charge: charge,
      cardsCount: 10,
    );
  });

  /// Constructor
  test('object can be constructed with all properties', () {
    expect(true, testModeSettings.paymentAuthorizationPassed);
    expect(false, testModeSettings.enablePaymentError);
    expect(charge, testModeSettings.charge);
    expect(10, testModeSettings.cardsCount);
    expect(false, testModeSettings.googlePayTestEnvironment);
  });

  test('object can be constructed without properties', () {
    final TestModeSettings actual = TestModeSettings(
      paymentAuthorizationPassed: true,
      enablePaymentError: false,
      charge: charge,
      cardsCount: 10,
    );
    expect(false, actual.googlePayTestEnvironment);
  });

  /// Serializable
  test('object can be serialized', () {
    final Map<String, Object?> actual = testModeSettings.toJson();
    final Map<String, Object?> matcher = <String, Object?>{
      'payment_authorization_passed': true,
      'enable_payment_error': false,
      'charge': charge.toJson(),
      'cards_count': 10,
      'google_pay_test_environment': false,
    };
    expect(actual, matcher);
  });
}
