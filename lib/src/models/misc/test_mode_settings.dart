import 'package:equatable/equatable.dart';
import 'package:flutter_yookassa_sdk/src/models/misc/amount.dart';
import 'package:meta/meta.dart';

/// {@macro test_mode_settings}
@immutable
class TestModeSettings extends Equatable {
  /// {@template test_mode_settings}
  /// Настройки тестового режима.
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

  /// {@macro amount}
  final Amount charge;

  /// Определяет, будет ли платеж завершен с ошибкой.
  final bool enablePaymentError;

  /// Использовать тестовую среду Google Pay - все транзакции,
  /// проведенные через Google Pay, будут использовать WalletConstants.ENVIRONMENT_TEST.
  /// Имейте ввиду, что при попытке оплаты с параметром googlePayTestEnvironment=true
  /// произойдет ошибка токенизации.
  /// Подробнее см. на https://developers.google.com/pay/api/android/guides/test-and-deploy/integration-checklist#about-the-test-environment.
  final bool googlePayTestEnvironment;

  Map<String, Object?> toJson() => <String, Object?>{
        'paymentAuthorizationPassed': paymentAuthorizationPassed,
        'cardsCount': cardsCount,
        'charge': charge.toJson(),
        'enablePaymentError': enablePaymentError,
        'googlePayTestEnvironment': googlePayTestEnvironment,
      };

  @override
  String toString() => 'TestModeSettings('
      'paymentAuthorizationPassed: $paymentAuthorizationPassed, '
      'cardsCount: $cardsCount, '
      'charge: $charge, '
      'enablePaymentError: $enablePaymentError, '
      'googlePayTestEnvironment $googlePayTestEnvironment)';

  @override
  List<Object?> get props => [
        paymentAuthorizationPassed,
        cardsCount,
        charge.props,
        enablePaymentError,
        googlePayTestEnvironment,
      ];
}
