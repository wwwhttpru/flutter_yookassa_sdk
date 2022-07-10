part of '../models.dart';

/// {@macro test_mode_settings}
class TestModeSettings {
  /// {@template test_mode_settings}
  /// Настройки для тестирование работоспособности Yookassa SDK.
  /// {@endtemplate}
  const TestModeSettings({
    required this.paymentAuthorizationPassed,
    required this.cardsCount,
    required this.charge,
    required this.enablePaymentError,
    this.googlePayTestEnvironment = false,
  });

  /// Определяет, пройдена ли платежная авторизация при оплате ЮMoney.
  final bool paymentAuthorizationPassed;

  /// Количество привязанные карт к кошельку в ЮMoney.
  final int cardsCount;

  /// Комиссия.
  ///
  /// {@macro amount}
  final Amount charge;

  /// Определяет, будет ли платеж завершен с ошибкой.
  final bool enablePaymentError;

  /// Использовать тестовую среду Google Pay - все транзакции,
  /// проведенные через Google Pay, будут использовать WalletConstants.ENVIRONMENT_TEST.
  /// Имейте ввиду, что при попытке оплаты с параметром googlePayTestEnvironment=true
  /// произойдет ошибка токенизации.
  final bool googlePayTestEnvironment;

  /// Конвертировать объект в JSON-формат.
  Map<String, Object?> toJson() => <String, Object?>{
        'payment_authorization_passed': paymentAuthorizationPassed,
        'cards_count': cardsCount,
        'charge': charge.toJson(),
        'enable_payment_error': enablePaymentError,
        'google_pay_test_environment': googlePayTestEnvironment,
      };
}
