import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_yookassa_sdk/flutter_yookassa_sdk.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> checkout() async {
    const testModeSettings = TestModeSettings(
      paymentAuthorizationPassed: true,
      cardsCount: 5,
      charge: Amount(value: 50, currency: Currency.rub()),
      enablePaymentError: false,
    );

    const inputData = TokenizationModuleInputData(
      clientApplicationKey: 'test_NzkxMjAyOuwoQvAL05i8dH3PKX66eL-iT7wMMQHCZmk',
      shopName: 'Shp Name Test',
      purchaseDescription: 'Description Example',
      amount: Amount(value: 200, currency: Currency.rub()),
      savePaymentMethod: SavePaymentMethod.userSelects,
      shopId: '111222333',
      tokenizationSettings: TokenizationSettings(
        paymentMethodTypes: PaymentMethodTypes.all(),
        showYooKassaLogo: false,
      ),
      testModeSettings: testModeSettings,
      isLoggingEnabled: false,
      moneyAuthClientId: 'test_client_id_123_123',
      googlePayParameters: GooglePayParameters(),
    );
    try {
      final paymentData =
          await FlutterYookassaSdk.instance.tokenization(inputData);
      print(paymentData);
    } on YooKassaException catch (error) {
      // Handle Error
      print('Error : $error');
    }
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> bankCardRepeat() async {
    const testModeSettings = TestModeSettings(
      paymentAuthorizationPassed: true,
      cardsCount: 5,
      charge: Amount(value: 50, currency: Currency.rub()),
      enablePaymentError: false,
    );

    const inputData = BankCardRepeatModuleInputData(
      clientApplicationKey: 'test_NzkxMjAyOuwoQvAL05i8dH3PKX66eL-iT7wMMQHCZmk',
      shopName: 'Shp Name Test',
      purchaseDescription: 'Description Example',
      amount: Amount(value: 200, currency: Currency.rub()),
      savePaymentMethod: SavePaymentMethod.userSelects,
      shopId: '111222333',
      testModeSettings: testModeSettings,
      isLoggingEnabled: false,
      paymentMethodId: '',
    );
    try {
      final paymentData =
          await FlutterYookassaSdk.instance.bankCardRepeat(inputData);
      print(paymentData);
    } on YooKassaException catch (error) {
      // Handle Error
      print('Error : $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: checkout,
              child: const Text('Checkout'),
            ),
            ElevatedButton(
              onPressed: bankCardRepeat,
              child: const Text('Bank Card Repeat'),
            ),
          ],
        )),
      ),
    );
  }
}
