import 'package:flutter_test/flutter_test.dart';
import 'package:yookassa_sdk_platform_interface/src/models/models.dart';

void main() {
  late final Currency rubCurrency;
  late final Amount amount;

  setUpAll(() {
    rubCurrency = const Currency.rub();
    amount = Amount(value: 200, currency: rubCurrency);
  });

  /// Test convert to JSON
  test('Convert toJson', () {
    final Map<String, Object?> actual = amount.toJson();
    final Map<String, Object?> expected = <String, Object?>{
      'value': 200,
      'currency': rubCurrency.toJson(),
    };
    expect(actual, expected);
  });
}
