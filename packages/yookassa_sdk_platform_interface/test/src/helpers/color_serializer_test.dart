import 'dart:ui' show Color;

import 'package:flutter_test/flutter_test.dart';
import 'package:yookassa_sdk_platform_interface/src/helpers/color_serializer.dart';

void main() {
  late final Color whiteColor;

  setUpAll(() {
    whiteColor = const Color(0xFFFFFFFF);
  });

  group('Serialization from JSON', () {
    test('#FFFFFF from json', () {
      final Color color = ColorSerializer.fromJson('#FFFFFF');
      expect(whiteColor, equals(color));
    });

    test('#FFFFFFFF from json', () {
      final Color color = ColorSerializer.fromJson('#FFFFFFFF');
      expect(whiteColor, equals(color));
    });
  });

  group('Serialization to JSON', () {
    test('#FFFFFFFF to json', () {
      final String json = ColorSerializer.toJson(whiteColor);
      expect(json, equals('#FFFFFFFF'));
    });
  });
}
