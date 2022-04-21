import 'dart:ui' show Color;

import 'package:flutter_test/flutter_test.dart';
import 'package:yookassa_sdk_platform_interface/src/models/models.dart';

void main() {
  test('BlueRibbon should equal color', () {
    expect(CustomizationColors.blueRibbon, equals(const Color(0xFF002C5E)));
  });
}
