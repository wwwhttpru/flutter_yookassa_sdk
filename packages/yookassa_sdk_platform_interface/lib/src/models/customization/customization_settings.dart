part of '../models.dart';

/// {@macro customization_settings}
class CustomizationSettings {
  /// {@template customization_settings}
  /// Настройки костюмизации.
  /// Отображение логотипа ЮКасса в приложении.
  /// {@endtemplate}
  const CustomizationSettings({
    this.mainScheme = CustomizationColors.blueRibbon,
    this.showYookassaLogo = true,
  });

  /// Цвет основных элементов, кнопки, переключатели, поля ввода.
  /// По умолчанию используется цвет [CustomizationColors.blueRibbon].
  final Color mainScheme;

  /// Отвечает за отображение логотипа ЮКасса.
  /// По умолчанию логотип отображается.
  final bool showYookassaLogo;

  /// Convert [CustomizationSettings] to json.
  Map<String, Object?> toJson() => <String, Object?>{
        'main_scheme': ColorSerializer.toJson(mainScheme),
        'show_yookassa_logo': showYookassaLogo,
      };
}
