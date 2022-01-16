import 'package:flutter_yookassa_sdk/src/models/help/enum_decode.dart';
import 'package:meta/meta.dart';

/// {@template save_payment_method}
/// Настройка сохранения способа оплаты. Если способ оплаты сохранен, магазин может производить регулярные платежи с помощью токена.
///
/// Для этой настройки есть три варианта:
///
/// `on` - всегда сохранять способ оплаты. Пользователь может выбрать только из тех способов оплаты, которые позволяют экономить.
/// На экране контракта пользователь увидит сообщение о сохранении способа оплаты.
///
/// `off` - не сохранять способ оплаты. Пользователь может выбрать любой из доступных способов оплаты.
///
/// `userSelects` - пользователь выбирает для сохранения способ оплаты (у пользователя будет переключатель для изменения
/// выбор, если способ оплаты можно сохранить).
/// {@endtemplate}
enum SavePaymentMethod {
  /// Сохранить платёжный метод для проведения рекуррентных платежей.
  /// Пользователю будут доступны только способы оплаты, поддерживающие
  /// сохранение. На экране контракта будет отображено сообщение о том,
  /// что платёжный метод будет сохранён.
  on,

  ///	Не дает пользователю выбрать, сохранять способ оплаты или нет.
  off,

  /// Пользователь выбирает, сохранять платёжный метод или нет.
  /// Если метод можно сохранить, на экране контракта появится переключатель.
  userSelects,
}

// ignore: avoid_classes_with_only_static_members
@internal
@immutable
class SavePaymentMethodModel {
  static SavePaymentMethod decode(Object? source) =>
      enumDecode<SavePaymentMethod, String>(
        savePaymentMethodEnumMap,
        source,
      );

  static String encode(SavePaymentMethod source) {
    final value = savePaymentMethodEnumMap[source];
    if (value == null) {
      throw ArgumentError(
        '`$source` is not one of the supported values: '
        '${savePaymentMethodEnumMap.values.join(', ')}',
      );
    }
    return value;
  }

  static const Map<SavePaymentMethod, String> savePaymentMethodEnumMap = {
    SavePaymentMethod.on: 'on',
    SavePaymentMethod.off: 'off',
    SavePaymentMethod.userSelects: 'user_selects',
  };
}
