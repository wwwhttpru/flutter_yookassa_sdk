import 'package:flutter_test/flutter_test.dart';
import 'package:yookassa_sdk_platform_interface/src/models/models.dart';

void main() {
  late final ConfirmationException exception;

  setUpAll(() {
    exception = const ConfirmationException();
  });

  test('Extends from YookassaException', () {
    expect(exception, isA<YookassaException>());
  });

  test('Message and detail must be equal to null', () {
    expect(exception.message, null);
    expect(exception.detail, null);
  });

  test('ToString', () {
    expect(
      exception.toString(),
      'ConfirmationException(message: null, detail: null)',
    );
  });
}
