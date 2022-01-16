import 'package:flutter_yookassa_sdk/src/models/exceptions/yoo_kassa_exception.dart';
import 'package:meta/meta.dart';

/// {@macro yoo_kassa_payments_exception}
@immutable
class YooKassaPaymentsException extends YooKassaException {
  /// {@template yoo_kassa_payments_exception}
  /// YooKassaPaymentsException
  /// {@endtemplate}
  const YooKassaPaymentsException([String? message])
      : super(message: message ?? 'Не удалось завершить операцию');

  @override
  String toString() => 'YooKassaPaymentsException(message: $message)';
}
