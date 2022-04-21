part of '../models.dart';

/// {@macro canceled_exception}
class CanceledException extends YookassaException {
  /// {@template canceled_exception}
  /// Это иссключение выбрасывается, если пользователь досрочно завершил операцию.
  /// {@endtemplate}
  const CanceledException() : super();

  @override
  String toString() => 'CanceledException()';
}
