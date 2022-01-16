# Flutter YooKassa Payments SDK

* [Android YooKassa Payments SDK](https://github.com/yoomoney/yookassa-android-sdk)
* [iOS YooKassa Payments SDK](https://github.com/yoomoney/yookassa-payments-swift)

Эта библиотека позволяет встроить прием платежей в мобильное приложение.
Она работает как дополнение к API ЮKassa.

В SDK входят готовые платежные интерфейсы (форма оплаты и всё, что с ней связано).

С помощью SDK можно получать токены для проведения оплаты с банковской карты, Google Pay, Сбербанка или из кошелька в ЮMoney.

Минимально поддерживаемая версия `ios sdk: 10.0`.
Минимально поддерживаемая версия` android sdk: 21(Android 5)`.

---

- [YooKassa Payments SDK](#flutter-yookassa-payments-sdk)
    - [Changelog](#changelog)
    - [Подключение зависимостей](#подключение-зависимостей)
        - [iOS](#ios)
        - [Android](#android)
    - [Быстрая интеграция](#быстрая-интеграция)
    - [ЮMoney](#ЮMoney)
    - [Банковская карта](#банковская-карта)
    - [SberPay](#sberpay)
        - [iOS SberPay](#ios-sberpay)
        - [Android SberPay](#android-sberpay)
    - [Apple Pay](#apple-pay)
    - [Использование платежного токена](#Использование-платежного-токена)
    - [3DSecure](#3DSecure)
    - [Логирование](#логирование)
    - [Тестовый режим](#тестовый-режим)
    - [Кастомизация интерфейса](#Кастомизация-интерфейса)
    - [Платёж привязанной к магазину картой с дозапросом CVC/CVV](#Платёж-привязанной-к-магазину-картой-с-дозапросом-CVC/CVV)
---
## Changelog

[Ссылка на Changelog](CHANGELOG.md)

## Подключение зависимостей

1. Добавьте зависимость в ваш `pubspec.yaml`
```
dependencies:
  flutter_yookassa_sdk: ^0.1.0
```

## iOS

Добавьте следующие строки в ваш `Podfile`.
```shell
source 'https://github.com/CocoaPods/Specs.git'
source 'https://github.com/yoomoney-tech/cocoa-pod-specs.git'

...
target 'Runner' do
  ...

  pod 'YooKassaPayments',
        :git => 'https://github.com/yoomoney/yookassa-payments-swift.git',
        :tag => '6.2.0'

  ...
end
...
```

### Подключение TMXProfiling и TMXProfilingConnections

Чтобы получить файл `.xcframework`, [зарегистрируйтесь в ЮKassa](https://yookassa.ru/joinups)
и сообщите вашему менеджеру, что хотите подключить мобильный SDK.

1. Используя Finder или другой файловый менеджер добавьте библиотеки `TMXProfiling.xcframework` и `TMXProfilingConnections.xcframework` в папку c вашим проектом.

2. В разделе `General` у основного таргета проекта добавьте `TMXProfiling.xcframework` и `TMXProfilingConnections.xcframework` в `Frameworks, Libraries, and Embedded Content`.

3. `TMXProfiling.xcframework` и `TMXProfilingConnections.xcframework` должны быть добавлены как `Embed & Sign`

## Android

### Конфигурация
Для подключения библиотеки пропишите в build.gradle:

```groovy
...
ext.kotlin_version = '1.4.32'
...
```

Попросите у менеджера по подключению библиотеку `ThreatMetrix Android SDK 6.2-97.aar`.
Создайте папку libs (android/app/libs) в модуле где подключаете sdk и добавьте туда файл `ThreatMetrix Android SDK 5.4-73.aar`. В android/app/build.gradle того же модуля в dependencies добавьте:
```groovy
dependencies {
    implementation fileTree(dir: "libs", include: ["*.aar"])
}
```

### Настройка приложения при продаже цифровых товаров
Если в вашем приложении продаются цифровые товары, нужно отключить Google Pay из списка платежных опций.
Для этого добавьте в AndroidManifest следующий код:

```xml
<meta-data
    android:name="com.google.android.gms.wallet.api.enabled"
    tools:node="remove" />
```

## Быстрая интеграция

1. Создайте `TokenizationModuleInputData` (понадобится [ключ для клиентских приложений](https://yookassa.ru/my/tunes) из личного кабинета ЮKassa). В этой модели передаются параметры платежа (валюта и сумма) и параметры платежной формы, которые увидит пользователь при оплате (способы оплаты, название магазина и описание заказа).

> Для работы с сущностями FlutterYookassaSdk импортируйте зависимости в исходный файл

```dart
import 'package:flutter_yookassa_sdk/flutter_yookassa_sdk.dart';
```

Пример создания `TokenizationModuleInputData`:

```dart
final inputData = TokenizationModuleInputData(
  clientApplicationKey: "live_AAAAAAAAAAAAAAAAAAAA",
  shopName: "Космические объекты",
  purchaseDescription: "Комета повышенной яркости, период обращения — 112 лет",
  amount: const Amount(value: 999, currency: Currency.rub()),
  savePaymentMethod: SavePaymentMethod.userSelects,
  shopId: '12345',
  tokenizationSettings: TokenizationSettings(
    paymentMethodTypes: PaymentMethodTypes.all(),
    showYooKassaLogo: false,
  ),
  moneyAuthClientId: 'client_id',
  googlePayParameters: GooglePayParameters(),
);
```

2. Запустите процесс токенизации
```dart
try {
  final paymentData =
    await FlutterYookassaSdk.instance().tokenization(inputData);
} on YooKassaException catch (err) {
  /// Обработка ошибки
}
```

При успешной токенизации. Он возвращает `PaymentData`, который состоит из:
* token (String) - платежный токен, см. [Использование платежного токена](#использование-платежного-токена);
* paymentMethod (String) - тип платежного средства.

### ЮMoney

> Если среди платёжных методов есть кошелёк ЮMoney, необходимо зарегистрировать приложение и получить `authCenterClientId`.
В остальных случаях этот шаг можно пропустить.

Для подключения способа оплаты `ЮMoney` необходимо:

1. Получить `client id` центра авторизации системы `ЮMoney`.
2. При создании `TokenizationModuleInputData` передать `client id` в параметре `moneyAuthClientId`

#### Как получить `client id` центра авторизации системы `ЮMoney`

1. Авторизуйтесь на [yookassa.ru](https://yookassa.ru)
2. Перейти на страницу регистрации клиентов СЦА - [yookassa.ru/oauth/v2/client](https://yookassa.ru/oauth/v2/client)
3. Нажать [Зарегистрировать](https://yookassa.ru/oauth/v2/client/create)
4. Заполнить поля:\
   4.1. "Название" - `required` поле, отображается при выдаче прав и в списке приложений.\
   4.2. "Описание" - `optional` поле, отображается у пользователя в списке приложений.\
   4.3. "Ссылка на сайт приложения" - `optional` поле, отображается у пользователя в списке приложений.\
   4.4. "Код подтверждения" - выбрать `Передавать в Callback URL`, можно указывать любое значение, например ссылку на сайт.
5. Выбрать доступы:\
   5.1. `Кошелёк ЮMoney` -> `Просмотр`\
   5.2. `Профиль ЮMoney` -> `Просмотр`\
   5.3. Доступы. Тут есть три раздела `API ЮKassa`, `Кошелёк ЮMoney`, `Профиль ЮMoney`.
    * В разделе `Кошелёк ЮMoney` выдайте разрешение на чтение баланса кошелька пользователя. Для этого в разделе **БАЛАНС КОШЕЛЬКА** поставьте галку на против поля **Просмотр**;
    * Откройте раздел `Профиль ЮMoney` и выдайте разрешение на чтение телефона, почты, имени и аватара пользователя. Для этого в разделе **ТЕЛЕФОН, ПОЧТА, ИМЯ И АВАТАР ПОЛЬЗОВАТЕЛЯ** поставьте галку на против поля **Просмотр**;
7. Нажать `Зарегистрировать`

#### Передать `client id` в параметре `moneyAuthClientId`

При создании `TokenizationModuleInputData` передать `client id` в параметре `moneyAuthClientId`

```dart
final inputData = TokenizationModuleInputData(
    ...
    moneyAuthClientId: "client_id")
```

Чтобы провести платеж:

1. При создании `TokenizationModuleInputData` передайте значение `.yooMoney` в `paymentMethodTypes.`
```dart
final inputData = TokenizationModuleInputData(
    ...
    tokenizationSettings: const TokenizationSettings(
      paymentMethodTypes: PaymentMethodTypes.yooMoney(),
    ),
    moneyAuthClientId: 'your_client_id',
);
```
2. Получите токен.
3. [Создайте платеж](https://yookassa.ru/developers/api#create_payment) с токеном по API ЮKassa.

#### Поддержка авторизации через мобильное приложение

1. В `TokenizationModuleInputData` необходимо передавать `applicationScheme` – схема для возврата в приложение после успешной авторизации в `ЮMoney` через мобильное приложение.

Пример `applicationScheme`:

```dart
final inputData = TokenizationModuleInputData(
    ...
    applicationScheme: 'examplescheme://'
```

2. В `AppDelegate` импортировать зависимость `YooKassaPayments`:

   ```swift
   import YooKassaPayments
   ```

3. Добавить обработку ссылок через `YKSdk` в `AppDelegate`:

```swift
func application(
    _ application: UIApplication,
    open url: URL,
    sourceApplication: String?, 
    annotation: Any
) -> Bool {
    return YKSdk.shared.handleOpen(
        url: url,
        sourceApplication: sourceApplication
    )
}

@available(iOS 9.0, *)
func application(
    _ app: UIApplication,
    open url: URL,
    options: [UIApplication.OpenURLOptionsKey: Any] = [:]
) -> Bool {
    return YKSdk.shared.handleOpen(
        url: url,
        sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String
    )
}
```

4. В `Info.plist` добавьте следующие строки:

```plistbase
<key>LSApplicationQueriesSchemes</key>
<array>
	<string>yoomoneyauth</string>
</array>
<key>CFBundleURLTypes</key>
<array>
	<dict>
		<key>CFBundleTypeRole</key>
		<string>Editor</string>
		<key>CFBundleURLName</key>
		<string>${BUNDLE_ID}</string>
		<key>CFBundleURLSchemes</key>
		<array>
			<string>examplescheme</string>
		</array>
	</dict>
</array>
```

где `examplescheme` - схема для открытия вашего приложения, которую вы указали в `applicationScheme` при создании `TokenizationModuleInputData`. Через эту схему будет открываться ваше приложение после успешной авторизации в `ЮMoney` через мобильное приложение.

### Банковская карта

1. При создании `TokenizationModuleInputData` передайте значение `.bankcard` в `paymentMethodTypes`.
```dart
final inputData = TokenizationModuleInputData(
    ...
    tokenizationSettings: const TokenizationSettings(
      paymentMethodTypes: PaymentMethodTypes.bankCard(),
    ),
);
```
2. Получите токен.
3. [Создайте платеж](https://yookassa.ru/developers/api#create_payment) с токеном по API ЮKassa.

## SberPay

### iOS SberPay
С помощью SDK можно провести платеж через «Мобильный банк» Сбербанка — с подтверждением оплаты через приложение Сбербанк Онлайн, если оно установленно, иначе с подтверждением по смс.

В `TokenizationModuleInputData` необходимо передавать `applicationScheme` – схема для возврата в приложение после успешной оплаты с помощью `SberPay` в приложении СберБанк Онлайн.

Пример `applicationScheme`:

```dart
final inputData = TokenizationModuleInputData(
      ...
      applicationScheme: 'examplescheme://'
```

Чтобы провести платёж:

1. При создании `TokenizationModuleInputData` передайте значение `.sberbank` в `paymentMethodTypes`.
2. Получите токен.
3. [Создайте платеж](https://yookassa.ru/developers/api#create_payment) с токеном по API ЮKassa.

Для подтверждения платежа через приложение СберБанк Онлайн:

1. В `AppDelegate` импортируйте зависимость `YooKassaPayments`:

   ```swift
   import YooKassaPayments
   ```

2. Добавьте обработку ссылок через `YKSdk` в `AppDelegate`:

```swift
func application(
    _ application: UIApplication,
    open url: URL,
    sourceApplication: String?, 
    annotation: Any
) -> Bool {
    return YKSdk.shared.handleOpen(
        url: url,
        sourceApplication: sourceApplication
    )
}

@available(iOS 9.0, *)
func application(
    _ app: UIApplication,
    open url: URL,
    options: [UIApplication.OpenURLOptionsKey: Any] = [:]
) -> Bool {
    return YKSdk.shared.handleOpen(
        url: url,
        sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String
    )
}
```

3. В `Info.plist` добавьте следующие строки:

```plistbase
<key>LSApplicationQueriesSchemes</key>
<array>
	<string>sberpay</string>
</array>
<key>CFBundleURLTypes</key>
<array>
	<dict>
		<key>CFBundleTypeRole</key>
		<string>Editor</string>
		<key>CFBundleURLName</key>
		<string>${BUNDLE_ID}</string>
		<key>CFBundleURLSchemes</key>
		<array>
			<string>examplescheme</string>
		</array>
	</dict>
</array>
```

где `examplescheme` - схема для открытия вашего приложения, которую вы указали в `applicationScheme` при создании `TokenizationModuleInputData`. Через эту схему будет открываться ваше приложение после успешной оплаты с помощью `SberPay`.

### Android SberPay
Для работы sdk нужно настроить схему вашего приложения для обработки deeplink. Это необходимо сделать для оплаты через sberpay.
Нужно добавить в ваш файл build.gradle в блок android.defaultConfig строку `resValue "string", "ym_app_scheme", "your_unique_app_shceme"`
```
android {
    defaultConfig {
        resValue "string", "ym_app_scheme", "your_unique_app_shceme"
    }
}
```
Или добавить в ваш strings.xml строку вида:
```
<resources>
    <string name="ym_app_scheme" translatable="false">your_unique_app_shceme</string>
</resources>
```
Где your_unique_app_shceme - это уникальное название вашего приложения, если вы уже обрабатывете deeplink в своём приложении, то можно использовать готовую схему вашего приложения.
Если ранее в проекте вы не обрабатывали deeplink, можно придумать уникальную схему для вашего приложения, состоящую из латинских букв.

### Apple Pay

1. Чтобы подключить Apple Pay, нужно передать в ЮKassa сертификат, с помощью которого Apple будет шифровать данные банковских карт.

Для этого:

- Напишите менеджеру и попросите создать для вас запрос на сертификат (`.csr`).
- Создайте сертификат в панели разработчика Apple (используйте `.csr`).
- Скачайте получившийся сертификат и пришлите менеджеру.

[Подробная инструкция](https://yookassa.ru/files/manual_connection_Apple_Pay(website).pdf) (см. раздел 2 «Обмен сертификатами с Apple»)

2. Включите Apple Pay в Xcode.

Чтобы провести платеж:

1. При инициализации объекта `TokenizationModuleInputData` необходимо передать [apple pay identifier](https://help.apple.com/xcode/mac/current/#/deva43983eb7?sub=dev171483d6e) в параметр `applePayMerchantIdentifier`.

```dart
final inputData = TokenizationModuleInputData(
    ...
    applePayMerchantIdentifier: "com.example.identifier"
```
2. Получите токен.
3. [Создайте платеж](https://yookassa.ru/developers/api#create_payment) с токеном по API ЮKassa.

### Использование платежного токена
Необходимо получить у менеджера ЮKassa разрешение на проведение платежей с использованием токена.
Токен одноразовый, срок действия — 1 час. Если не создать платеж в течение часа, токен нужно будет запрашивать заново.

В платежном токене содержатся данные о [сценарии подтверждения](https://yookassa.ru/developers/payments/payment-process#user-confirmation) платежа.
После получения платежного токена Вы можете [создать платеж](https://yookassa.ru/developers/api#create_payment), в параметре `payment_token` передайте платежный токен.
Если платеж проводится с аутентификацией по 3-D Secure, используйте `confirmation_url`, который придет в объекте [Платежа](https://yookassa.ru/developers/api#payment_object).
Используйте `confirmation_url` для запуска 3-D Secure, см. [3DSecure](#3DSecure).

Так же, Вы можете получить [информацию о платеже](https://yookassa.ru/developers/api#get_payment)

### 3DSecure
1. Вызовите 3DSecure
```dart
await FlutterYookassaSdk.instance().confirm3dsCheckout(
      confirmationUrl: confirmationUrl,
      paymentMethodType: paymentMethod,
);
```

2. После успешного 3DSecure не гарантируется что успешно, рекомендуется запросить статус платежа
3. Завершите процесс покупки ЮКассу
## Логирование

У вас есть возможность включить логирование всех сетевых запросов.\
Для этого необходимо при создании `TokenizationModuleInputData` передать `isLoggingEnabled: true`

```dart
final inputData = TokenizationModuleInputData(
    ...
    isLoggingEnabled: true)
```

## Тестовый режим

У вас есть возможность запустить мобильный SDK в тестовом режиме.\
Тестовый режим не выполняет никаких сетевых запросов и имитирует ответ от сервера.

Если вы хотите запустить SDK в тестовом режиме, необходимо:

1. Сконфигурировать объект с типом `TestModeSettings`.

```dart
final testModeSettings = TestModeSettings(
  paymentAuthorizationPassed: true,
  cardsCount: 5,
  charge: Amount(value: 50, currency: Currency.rub()),
  enablePaymentError: false,
);
```

2. Передать его в `TokenizationModuleInputData` в параметре `testModeSettings:`

```dart
final inputData = TokenizationModuleInputData(
    ...
    testModeSettings: testModeSettings)
```

## Кастомизация интерфейса

По умолчанию используется цвет blueRibbon. Цвет основных элементов, кнопки, переключатели, поля ввода.

1. Сконфигурировать объект `CustomizationSettings` и передать его в параметр `customizationSettings` объекта `TokenizationModuleInputData`.

```dart
final inputData = TokenizationModuleInputData(
    ...
    customizationSettings: CustomizationSettings(mainScheme: Colors.blue ),
);
```

## Платёж привязанной к магазину картой с дозапросом CVC/CVV

```dart
      final paymentData = await FlutterYookassaSdk.instance().bankCardRepeat(
        BankCardRepeatModuleInputData(
          clientApplicationKey: clientApplicationKey,
          shopName: shopName,
          purchaseDescription: purchaseDescription,
          shopId: 'mock_id',
          paymentMethodId: 'method_id',
          amount: Amount(value: value, currency: currency),
          savePaymentMethod: savePaymentMethod,
        ),
      );
```