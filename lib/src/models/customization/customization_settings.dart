import 'dart:ui' show Color;

import 'package:equatable/equatable.dart';
import 'package:flutter_yookassa_sdk/src/models/customization/customization_colors.dart';
import 'package:flutter_yookassa_sdk/src/models/help/color_serialiser.dart';
import 'package:meta/meta.dart';

/// {@macro customization_settings}
@immutable
class CustomizationSettings extends Equatable {
  /// {@template customization_settings}
  /// Настройки костюмизации
  /// {@endtemplate}
  const CustomizationSettings({
    this.mainScheme = CustomizationColors.blueRibbon,
  });

  /// Цвет основных элементов, кнопки, переключатели, поля ввода.
  /// По умолчанию используется цвет [CustomizationColors.blueRibbon].
  final Color mainScheme;

  Map<String, Object?> toJson() => <String, Object?>{
        'mainScheme': ColorSerialiser.toJson(mainScheme),
      };

  @override
  String toString() => 'CustomizationSettings(mainScheme: $mainScheme)';

  @override
  List<Object?> get props => [mainScheme];
}

@internal
@immutable
class CustomizationSettingsModel extends CustomizationSettings {
  const CustomizationSettingsModel({
    Color mainScheme = CustomizationColors.blueRibbon,
  }) : super(mainScheme: mainScheme);

  factory CustomizationSettingsModel.fromJson(Map<String, Object?> json) =>
      CustomizationSettingsModel(
        mainScheme: ColorSerialiser.fromJson(json['mainScheme']! as String),
      );
}
