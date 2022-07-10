part of '../models.dart';

/// {@macro customization_colors}
abstract class CustomizationColors {
  /// {@template customization_colors}
  /// Цвета для настройки.
  /// {@endtemplate}
  const CustomizationColors._();

  /// BlueRibbon цвет, взятый из iOS.
  static const Color blueRibbon = Color.fromRGBO(0, 44, 94, 1);
}
