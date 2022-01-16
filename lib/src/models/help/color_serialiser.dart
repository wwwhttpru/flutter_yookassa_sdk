import 'dart:ui' show Color;

import 'package:meta/meta.dart';

/// {@macro color_serialiser}
@internal
abstract class ColorSerialiser {
  /// {@template color_serialiser}
  /// Объект для сериализации/десориализации цветов Flutter
  /// {@endtemplate}
  const ColorSerialiser._();

  static Color fromJson(String json) {
    final color = json.replaceAll('#', '');
    if (color.length == 8) {
      return Color(int.parse('0x$color'));
    }
    return Color(int.parse('0xFF$color'));
  }

  static String toJson(Color color) =>
      '#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}';
}
