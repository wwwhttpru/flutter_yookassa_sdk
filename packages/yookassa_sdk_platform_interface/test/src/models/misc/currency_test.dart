import 'package:flutter_test/flutter_test.dart';
import 'package:yookassa_sdk_platform_interface/src/models/models.dart';

void main() {
  late final Currency currency;

  setUpAll(() {
    currency = const Currency(value: 'unknown');
  });

  /// Проверка конструктора
  test('Check default constructor', () {
    expect(currency.value, 'unknown');
  });

  /// Проверка конструктора рублей
  test('Check rub constructor', () {
    const Currency currency = Currency.rub();
    expect(currency.value, 'RUB');
  });

  /// Проверка конструктора долларов
  test('Check usd constructor', () {
    const Currency currency = Currency.usd();
    expect(currency.value, 'USD');
  });

  /// Проверка конструктора евро
  test('Check eur constructor', () {
    const Currency currency = Currency.eur();
    expect(currency.value, 'EUR');
  });

  /// Конвертация в JSON
  test('Check convert toJson', () {
    final Map<String, Object?> actual = currency.toJson();
    final Map<String, Object?> matcher = <String, Object?>{'value': 'unknown'};
    expect(actual, matcher);
  });
}
