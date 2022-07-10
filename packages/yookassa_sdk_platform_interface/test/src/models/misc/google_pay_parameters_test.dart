import 'package:flutter_test/flutter_test.dart';
import 'package:yookassa_sdk_platform_interface/src/models/models.dart';

void main() {
  late final GooglePayParameters googlePayParameters;
  setUpAll(() {
    googlePayParameters = const GooglePayParameters();
  });

  /// Test case: Default values.
  test('allowedCardNetworks default all values', () {
    final Set<GooglePayCardNetwork> actual =
        googlePayParameters.allowedCardNetworks;
    const List<GooglePayCardNetwork> matcher = GooglePayCardNetwork.values;
    expect(actual, matcher);
  });

  /// Convert to JSON.
  test('Convert to JSON', () {
    final Map<String, Object?> actual = googlePayParameters.toJson();
    final Map<String, Object?> matcher = <String, Object?>{
      'allowed_card_networks': <String>[
        'amex',
        'discover',
        'jcb',
        'mastercard',
        'visa',
        'interac',
        'other',
      ],
    };
    expect(actual, matcher);
  });
}
