import 'package:meta/meta.dart';

/// {@macro yoo_kassa_exception}
@immutable
abstract class YooKassaException implements Exception {
  /// {@template yoo_kassa_exception}
  /// Yookassa Exception
  /// {@endtemplate}
  const YooKassaException({
    required final this.message,
  });

  final String message;

  @override
  String toString() => 'YookassaException(message: $message)';
}
