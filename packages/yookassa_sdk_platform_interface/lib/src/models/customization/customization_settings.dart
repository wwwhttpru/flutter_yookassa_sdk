part of '../models.dart';

/// {@macro customization_settings}
class CustomizationSettings {
  /// {@template customization_settings}
  /// Настройки костюмизации интерфейса.
  ///
  /// За цвето основных (кнопки, переключатели, поля ввода)
  /// элементов отвечает [mainScheme].
  /// По умолчанию используется цвет [CustomizationColors.blueRibbon].
  ///
  /// Логотип по умолчанию отображается. Если вы не хотите его отображать,
  /// установить [showYookassaLogo] в false.
  /// {@endtemplate}
  const CustomizationSettings({
    this.mainScheme = CustomizationColors.blueRibbon,
    this.showYookassaLogo = true,
  });

  /// Цвет основных элементов, кнопки, переключатели, поля ввода.
  final Color mainScheme;

  /// Отвечает за отображение логотипа ЮКасса.
  final bool showYookassaLogo;

  /// Конвертировать [CustomizationSettings] в json.
  Map<String, Object?> toJson() => <String, Object?>{
        'main_scheme': ColorSerializer.toJson(mainScheme),
        'show_yookassa_logo': showYookassaLogo,
      };
}
