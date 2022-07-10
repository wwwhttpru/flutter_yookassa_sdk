import 'package:flutter_test/flutter_test.dart';
import 'package:yookassa_sdk_platform_interface/src/models/models.dart';

void main() {
  late final YookassaException exception;

  setUpAll(() {
    exception = MockYookassaException(
      message: 'Custom message',
      detail: 'Custom detail',
    );
  });

  test('Custom message and custom detail in exception', () {
    expect(exception.message, 'Custom message');
    expect(exception.detail, 'Custom detail');
  });

  test('ToString', () {
    expect(
      exception.toString(),
      'YookassaException(message: Custom message, detail: Custom detail)',
    );
  });
}

class MockYookassaException extends YookassaException {
  MockYookassaException({
    String? message,
    String? detail,
  }) : super(
          message: message,
          detail: detail,
        );
}
