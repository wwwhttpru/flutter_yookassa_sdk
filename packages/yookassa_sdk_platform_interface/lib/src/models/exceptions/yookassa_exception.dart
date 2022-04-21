part of '../models.dart';

/// {@macro yookassa_exception}
abstract class YookassaException implements Exception {
  /// {@template yookassa_exception}
  /// Выбрасывается при ошибке в процессе выполнения токенизации или подтверждения.
  ///
  ///
  /// [message] - сообщение об ошибке, может быть пустым
  /// [detail] - детализация ошибки, может быть пустым
  /// {@endtemplate}
  const YookassaException({
    this.message,
    this.detail,
  });

  /// Сообщение об ошибке.
  final String? message;

  /// Подробности об ошибке.
  final String? detail;

  @override
  String toString() => 'YookassaException(message: $message, detail: $detail)';
}
