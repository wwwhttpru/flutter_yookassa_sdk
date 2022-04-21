part of '../models.dart';

/// {@macro auth_client_id_not_found_exception}
class AuthClientIdNotFoundException implements YookassaException {
  /// {@template auth_client_id_not_found_exception}
  /// Это иссключение выбрасывается, если пользователь передал
  /// способ оплаты [PaymentMethodType.yooMoney], и не указал [moneyAuthClientId].
  /// {@endtemplate}
  const AuthClientIdNotFoundException();

  @override
  String? get message =>
      'Please provide [moneyAuthClientId] for yooMoney payment method.';

  @override
  String? get detail => null;

  @override
  String toString() =>
      'AuthClientIdNotFoundException(message: $message, detail: $detail)';
}
