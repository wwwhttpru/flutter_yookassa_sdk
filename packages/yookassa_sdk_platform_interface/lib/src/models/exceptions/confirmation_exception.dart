part of '../models.dart';

/// {@macro confirmation_exception}
class ConfirmationException extends YookassaException {
  /// {@template confirmation_exception}
  /// Это иссключение выбрасывается, при попытке подтвердить платеж.
  /// Во время 3ds произошла какая-то ошибка (нет соединения или что-то еще).
  ///
  /// Юкасса может передать сообщение об ошибке в [message], но не всегда.
  /// Так же в [detail] может содержаться дополнительная информация об ошибке,
  /// такие как код, и описание.
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
