import 'package:flutter_test/flutter_test.dart';
import 'package:yookassa_sdk_platform_interface/src/models/models.dart';

void main() {
  test('SavePaymentMethod should contain 3 options', () {
    const List<SavePaymentMethod> values = SavePaymentMethod.values;

    expect(values.length, 3);
  });

  test('SavePaymentMethod enum should have items in correct index', () {
    const List<SavePaymentMethod> values = SavePaymentMethod.values;

    expect(values[0], SavePaymentMethod.on);
    expect(values[1], SavePaymentMethod.off);
    expect(values[2], SavePaymentMethod.userSelects);
  });

  test('SavePaymentMethod should have correct values', () {
    const List<SavePaymentMethod> values = SavePaymentMethod.values;

    expect(values[0].toJson, 'on');
    expect(values[1].toJson, 'off');
    expect(values[2].toJson, 'user_selects');
  });
}
