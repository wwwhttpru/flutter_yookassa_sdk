import 'package:flutter_test/flutter_test.dart';
import 'package:yookassa_sdk_platform_interface/src/models/models.dart';

void main() {
  late final CustomizationSettings customizationSettings;

  setUpAll(() {
    customizationSettings = const CustomizationSettings();
  });

  test('MainScheme default value is CustomizationColors.blueRibbon', () {
    expect(customizationSettings.mainScheme, CustomizationColors.blueRibbon);
  });

  test('showYookassaLogo default value is true', () {
    expect(customizationSettings.showYookassaLogo, isTrue);
  });

  /// Test to json
  test('toJson', () {
    final Map<String, Object?> actual = customizationSettings.toJson();
    final Map<String, Object?> expected = <String, Object?>{
      'main_scheme': ColorSerializer.toJson(CustomizationColors.blueRibbon),
      'show_yookassa_logo': true,
    };
    expect(actual, expected);
  });
}
