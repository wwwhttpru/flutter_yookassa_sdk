part of '../models.dart';

/// {@macro tokenization_exception}
class TokenizationException extends YookassaException {
  /// {@template tokenization_exception}
  /// Это иссключение выбрасывается, при попытке токенизации.
  /// Произошла какая-то ошибка (нет соединения или что-то еще).
  ///
  /// [message] - сообщение об ошибке, может быть пустым.
  /// [detail] - содержать код ошибки и описание, может быть пустым.
  /// {@endtemplate}
  const TokenizationException({
    String? message,
    String? detail,
  }) : super(
          message: message,
          detail: detail,
        );

  @override
  String toString() =>
      'TokenizationException(message: $message, detail: $detail)';
}
