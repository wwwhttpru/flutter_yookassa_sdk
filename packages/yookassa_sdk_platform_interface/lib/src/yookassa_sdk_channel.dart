import 'package:flutter/services.dart';

import 'constants.dart';
import 'models/models.dart';
import 'yookassa_sdk_interface.dart';

/// Реализация [YookassaSdkInterface], использующая каналы методов.
class YookassaSdkChannel extends YookassaSdkInterface {
  /// Канал метода, используемый для взаимодействия с собственной платформой.
  static const MethodChannel _channel = MethodChannel(kChannel);

  @override
  Future<PaymentData> tokenization(
    TokenizationModuleInputData inputData,
  ) async {
    // Проверяем наличие способо оплаты yooMoney.
    _checkYooMoney(inputData);
    try {
      final Map<String, Object?>? result =
          await _channel.invokeMapMethod<String, Object?>(
        kPaymentTokenization,
        inputData.toJson(),
      );
      if (result == null) {
        throw ArgumentError.value(
          result,
          'Map result',
          'The result of tokenization must not be null',
        );
      }
      return PaymentData.fromJson(result);
    } on PlatformException catch (error) {
      final Exception exception = _handlePlatformException(error);
      throw exception;
    }
  }

  @override
  Future<PaymentData> bankCardRepeat(
    BankCardRepeatModuleInputData inputData,
  ) async {
    try {
      final Map<String, Object?>? result =
          await _channel.invokeMapMethod<String, Object?>(
        kCardTokenization,
        inputData.toJson(),
      );
      if (result == null) {
        throw ArgumentError.value(
          result,
          'Map result',
          'The result of bankCardRepeat must not be null',
        );
      }
      return PaymentData.fromJson(result);
    } on PlatformException catch (error) {
      final Exception exception = _handlePlatformException(error);
      throw exception;
    }
  }

  @override
  Future<void> confirmation(ConfirmInputData inputData) {
    try {
      return _channel.invokeMethod<void>(kConfirmation, inputData.toJson());
    } on PlatformException catch (error) {
      final Exception exception = _handlePlatformException(error);
      throw exception;
    }
  }

  /// Проверить наличие способа оплаты yooMoney, а так же [moneyAuthClientId].
  ///
  /// Если присутствует способ оплаты yooMoney,
  /// но отсутствует [moneyAuthClientId]
  /// выбросит ошибку [AuthClientIdNotFoundException].
  void _checkYooMoney(TokenizationModuleInputData inputData) {
    final Set<PaymentMethodType> values =
        inputData.tokenizationSettings.paymentMethodTypes.rawValue;
    if (values.contains(PaymentMethodType.yooMoney) &&
        inputData.moneyAuthClientId == null) {
      throw const AuthClientIdNotFoundException();
    }
  }

  /// Обрабатывает [PlatformException], созданное Flutter SDK.
  Exception _handlePlatformException(PlatformException exception) {
    switch (exception.code) {
      case kInvalidTokenizationCode:
        return TokenizationException(
          message: exception.message,
          detail: exception.details as String?,
        );
      case kInvalidConfirmationCode:
        return ConfirmationException(
          message: exception.message,
          detail: exception.details as String?,
        );
      case kCancelledCode:
        return const CanceledException();
      default:
        return exception;
    }
  }
}