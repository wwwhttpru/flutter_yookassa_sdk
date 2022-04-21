part of '../models.dart';

/// {@macro confirmation_exception}
class ConfirmationException extends YookassaException {
  /// {@template confirmation_exception}
  /// Это иссключение выбрасывается, при попытке подтвердить покупку.
  /// Во время 3ds произошла какая-то ошибка (нет соединения или что-то еще).
  ///
  /// [message] - сообщение об ошибке, может быть пустым.
  /// [detail] - содержать код ошибки и описание, может быть пустым.
  /// {@endtemplate}
  const ConfirmationException({
    String? message,
    String? detail,
  }) : super(
          message: message,
          detail: detail,
        );

  @override
  String toString() =>
      'ConfirmationException(message: $message, detail: $detail)';
}
