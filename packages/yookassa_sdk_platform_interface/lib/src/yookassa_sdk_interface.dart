import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'models/models.dart';
import 'yookassa_sdk_channel.dart';

/// The interface that implementations of YookassaSDK must implement.
abstract class YookassaSdkInterface extends PlatformInterface {
  /// Constructs a YookassaSdkInterface.
  YookassaSdkInterface() : super(token: _token);

  static YookassaSdkInterface _instance = YookassaSdkChannel();

  static const Object _token = Object();

  /// The default instance of [YookassaSdkInterface] to use.
  ///
  /// Defaults to [YookassaSdkChannel].
  static YookassaSdkInterface get instance => _instance;

  /// Platform-specific plugins should set this with their own
  /// platform-specific class that extends [YookassaSdkInterface] when they
  /// register themselves.
  static set instance(YookassaSdkInterface instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Запуск токенизации нескольких способов оплаты, таких как:
  /// Банковская карта, YooMoney, Сбербанк-Онлайн, Apple Pay.
  /// В случае успешной токенизации, возвращает [PaymentData].
  ///
  /// Если среди платёжных методов [PaymentMethodType.yooMoney]
  /// есть кошелёк ЮMoney, необходимо зарегистрировать приложение
  /// и получить [moneyAuthClientId].
  /// Если вы передали способ оплаты [PaymentMethodType.yooMoney], но не указали [moneyAuthClientId],
  /// то будет выбрашено исключение [AuthClientIdNotFoundException].
  ///
  /// В случае ошибки выбросит исключение [TokenizationException].
  /// Если пользователь отменил токенизацию, возвращает [CanceledException].
  Future<PaymentData> tokenization(TokenizationModuleInputData inputData) {
    throw UnimplementedError('tokenization() has not been implemented.');
  }

  /// Запуск токенизации банковской карты.
  /// Этот метод следует использовать, если вы сохранили карту пользователя
  /// и хотите, чтобы пользователь повторно вошел в csc.
  /// В случае успешной токенизации, возвращает [PaymentData].
  ///
  /// В случае ошибки выбросит исключение [TokenizationException].
  /// Если пользователь отменил токенизацию, возвращает [CanceledException].
  Future<PaymentData> bankCardRepeat(BankCardRepeatModuleInputData inputData) {
    throw UnimplementedError('bankCardRepeat() has not been implemented.');
  }

  /// Запустить процесс подтверждения платежа.
  /// Это не гарантрирует, что платеж завершился успехом или нет.
  /// Рекомендуется запросить статус платежа.
  ///
  /// В случае ошибки выбросит исключение [ConfirmationException].
  /// Если пользователь отменил подтверждение, возвращает [CanceledException].
  Future<void> confirmation(ConfirmInputData inputData) {
    throw UnimplementedError('confirmation() has not been implemented.');
  }
}
