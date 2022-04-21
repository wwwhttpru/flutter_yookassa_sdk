part of flutter_yookassa_sdk;

/// TODO: Documentation
class FlutterYookassaSdk {
  /// TODO: Documentation
  static Future<PaymentData> tokenization(
      TokenizationModuleInputData inputData,) =>
      YookassaSdkInterface.instance.tokenization(inputData);

  /// TODO: Documentation
  static Future<PaymentData> bankCardRepeat(
      BankCardRepeatModuleInputData inputData,) =>
      YookassaSdkInterface.instance.bankCardRepeat(inputData);

  /// TODO: Documentation
  static Future<void> confirmation(ConfirmInputData inputData) =>
      YookassaSdkInterface.instance.confirmation(inputData);
}
