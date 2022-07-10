part of '../models.dart';

/// {@macro auth_client_id_not_found_exception}
class AuthClientIdNotFoundException extends YookassaException {
  /// {@template auth_client_id_not_found_exception}
  /// Это иссключение выбрасывается, если пользователь передал
  /// способ оплаты [PaymentMethodType.yooMoney], и не указал [moneyAuthClientId].
  /// {@endtemplate}
  const AuthClientIdNotFoundException() : super();

  @override
  String toString() => 'AuthClientIdNotFoundException()';
}
