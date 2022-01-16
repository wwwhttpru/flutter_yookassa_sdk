// ignore_for_file: prefer_constructors_over_static_methods

import 'package:flutter/services.dart';
import 'package:flutter_yookassa_sdk/src/input_data/input_data.dart';
import 'package:flutter_yookassa_sdk/src/models/exceptions/exceptions.dart';
import 'package:flutter_yookassa_sdk/src/models/result/result.dart';

class FlutterYookassaSdk {
  const FlutterYookassaSdk._();

  static FlutterYookassaSdk? _instance;

  /// Returns an instance
  static FlutterYookassaSdk get instance {
    _instance ??= const FlutterYookassaSdk._();
    return _instance!;
  }

  MethodChannel get _channel => const MethodChannel('flutter_yookassa_sdk');

  /// Поток для токенизации нескольких способов оплаты, таких как:
  /// Банковская карта, YooMoney, Сбербанк-Онлайн, Apple Pay.
  Future<PaymentData> tokenization(
    TokenizationModuleInputData inputData,
  ) async {
    final result = await _channel.invokeMapMethod<String, Object?>(
      'tokenization',
      inputData.toJson(),
    );
    if (result == null) {
      throw const YooKassaPaymentsException();
    }
    final tokenResult = TokenizationResultModel.fromJson(result);
    final data = tokenResult.data;
    if (tokenResult.success && data != null) {
      return data;
    } else {
      throw YooKassaPaymentsException(tokenResult.error);
    }
  }

  /// В потоке токенизации хранятся способы оплаты по id метода оплаты.
  Future<PaymentData> bankCardRepeat(
    BankCardRepeatModuleInputData inputData,
  ) async {
    final message = inputData.toJson();
    final result = await _channel.invokeMapMethod<String, Object?>(
      'bankCardRepeat',
      message,
    );
    if (result == null) {
      throw const YooKassaPaymentsException();
    }
    final tokenResult = TokenizationResultModel.fromJson(result);
    final data = tokenResult.data;
    if (tokenResult.success && data != null) {
      return data;
    } else {
      throw YooKassaPaymentsException(tokenResult.error);
    }
  }

  Future<void> confirm3dsCheckout({
    required String confirmationUrl,
    required String paymentMethodType,
  }) async {
    final result = await _channel.invokeMapMethod<String, Object?>(
      'confirm3dsCheckout',
      ConfirmCheckoutModuleInputData(
        confirmationUrl: confirmationUrl,
        paymentMethodType: paymentMethodType,
      ).toJson(),
    );
    if (result == null) {
      throw const YooKassaPaymentsException();
    }
    final tokenResult = TokenizationResultModel.fromJson(result);
    if (tokenResult.success) {
      return;
    } else {
      throw YooKassaPaymentsException(tokenResult.error);
    }
  }
}
