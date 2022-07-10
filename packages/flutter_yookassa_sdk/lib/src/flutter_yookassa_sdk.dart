part of flutter_yookassa_sdk;

/// Класс для кроссплатформенного взаимодействия с Yookassa SDK.
class FlutterYookassaSdk {
  /// Запуск токенизации нескольких способов оплаты, таких как:
  /// Банковская карта, YooMoney, Сбербанк-Онлайн, Apple Pay.
  /// В случае успешной токенизации, возвращает [PaymentData].
  ///
  /// Если среди платёжных методов [PaymentMethodType.yooMoney]
  /// есть кошелёк ЮMoney, необходимо зарегистрировать приложение
  /// и получить [moneyAuthClientId].
  /// Если вы передали способ оплаты [PaymentMethodType.yooMoney],
  /// но не указали [moneyAuthClientId], то будет выбрашено
  /// исключение [AuthClientIdNotFoundException].
  ///
  /// В случае ошибки выбросит исключение [TokenizationException].
  /// Если пользователь отменил токенизацию, возвращает [CanceledException].
  static Future<PaymentData> tokenization(
    TokenizationModuleInputData inputData,
  ) =>
      YookassaSdkInterface.instance.tokenization(inputData);

  /// Запуск токенизации банковской карты.
  /// Этот метод следует использовать, если вы сохранили карту пользователя
  /// и хотите, чтобы пользователь повторно вошел в csc.
  /// В случае успешной токенизации, возвращает [PaymentData].
  ///
  /// В случае ошибки выбросит исключение [TokenizationException].
  /// Если пользователь отменил токенизацию, возвращает [CanceledException].
  static Future<PaymentData> bankCardRepeat(
    BankCardRepeatModuleInputData inputData,
  ) =>
      YookassaSdkInterface.instance.bankCardRepeat(inputData);

  /// Запустить процесс подтверждения платежа.
  /// Это не гарантрирует, что платеж завершился успехом или нет.
  /// Рекомендуется запросить статус платежа.
  ///
  /// В случае ошибки выбросит исключение [ConfirmationException].
  /// Если пользователь отменил подтверждение, возвращает [CanceledException].
  static Future<void> confirmation(ConfirmInputData inputData) =>
      YookassaSdkInterface.instance.confirmation(inputData);
}
