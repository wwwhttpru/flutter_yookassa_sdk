part of '../models.dart';

/// {@macro tokenization_exception}
class TokenizationException extends YookassaException {
  /// {@template tokenization_exception}
  /// Это иссключение выбрасывается, при попытке токенизации.
  /// Произошла какая-то ошибка (нет соединения или что-то еще).
  ///
  /// Юкасса может передать сообщение об ошибке в [message], но не всегда.
  /// Так же в [detail] может содержаться дополнительная информация об ошибке,
  /// такие как код, и описание.
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
