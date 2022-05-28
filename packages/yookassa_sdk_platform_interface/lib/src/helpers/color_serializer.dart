part of '../models/models.dart';

/// {@macro color_serializer}
@internal
abstract class ColorSerializer {
  /// {@template color_serializer}
  /// Объект для сериализации/десориализации цвета.
  ///
  /// Используется только внутри библиотеки.
  /// {@endtemplate}
  const ColorSerializer._();

  /// Конфертировать строку [json] в [Color]
  static Color fromJson(String json) {
    final String color = json.replaceAll('#', '');
    if (color.length == 8) {
      return Color(int.parse('0x$color'));
    }
    return Color(int.parse('0xFF$color'));
  }

  /// Конвертировать цвет [color] в строку
  static String toJson(Color color) =>
      '#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}';
}
