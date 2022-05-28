part of '../models.dart';

/// {@macro yookassa_exception}
abstract class YookassaException implements Exception {
  /// {@template yookassa_exception}
  /// Базовый класс для ошибок при работе с YookassaSDK.
  ///
  /// Юкасса может передать сообщение об ошибке в [message], но не всегда.
  /// Так же в [detail] может содержаться дополнительная информация об ошибке,
  /// такие как код, и описание.
  /// {@endtemplate}
  const YookassaException({
    this.message,
    this.detail,
  });

  /// Сообщение об ошибке.
  final String? message;

  /// Дополнительная информация об ошибке.
  final String? detail;

  @override
  String toString() => 'YookassaException(message: $message, detail: $detail)';
}
