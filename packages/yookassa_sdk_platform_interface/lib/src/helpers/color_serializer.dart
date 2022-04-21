import 'dart:ui' show Color;

import 'package:meta/meta.dart';

/// {@macro color_serializer}
@internal
abstract class ColorSerializer {
  /// {@template color_serializer}
  /// Объект для сериализации/десориализации цветов Flutter
  /// {@endtemplate}
  const ColorSerializer._();

  /// Convert json to [Color]
  static Color fromJson(String json) {
    final String color = json.replaceAll('#', '');
    if (color.length == 8) {
      return Color(int.parse('0x$color'));
    }
    return Color(int.parse('0xFF$color'));
  }

  /// Convert [Color] to json
  static String toJson(Color color) =>
      '#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}';
}
