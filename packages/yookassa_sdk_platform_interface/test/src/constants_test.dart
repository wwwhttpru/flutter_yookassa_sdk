import 'package:flutter_test/flutter_test.dart';
import 'package:yookassa_sdk_platform_interface/src/constants.dart';

void main() {
  test('The channel name must be equal to', () {
    expect(kChannel, 'plugin.wwwhttpru/yookassa_sdk_channel');
  });

  test('The invoke method payment tokenization name must be equal to', () {
    expect(kPaymentTokenization, 'payment_tokenization');
  });

  test('The invoke method card tokenization name must be equal to', () {
    expect(kCardTokenization, 'card_tokenization');
  });

  test('The invoke method confirmation must be equal to', () {
    expect(kConfirmation, 'confirmation');
  });

  test('Error codes must be equal to', () {
    expect(kNotImplementedCode, 'not_implemented');
    expect(kInvalidParametersCode, 'invalid_parameters');
    expect(kInvalidConverterCode, 'invalid_converter');
    expect(kCancelledCode, 'cancelled');
    expect(kInvalidTokenizationCode, 'invalid_tokenization');
    expect(kInvalidConfirmationCode, 'invalid_confirmation');
    expect(kInvalidAppCode, 'invalid_app');
  });
}
