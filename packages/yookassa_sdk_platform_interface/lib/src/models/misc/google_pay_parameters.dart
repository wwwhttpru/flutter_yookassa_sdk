part of '../models.dart';

/// {@macro google_pay_parameters}
class GooglePayParameters {
  /// {@template google_pay_parameters}
  /// Настройки для оплаты через Google Pay.
  ///
  /// По умолчанию используются все возможные платежные системы.
  /// {@endtemplate}
  const GooglePayParameters({
    this.allowedCardNetworks = const <GooglePayCardNetwork>{
      ...GooglePayCardNetwork.values,
    },
  });

  /// Список возможных платежных систем.
  ///
  /// {@macro google_pay_card_network}
  final Set<GooglePayCardNetwork> allowedCardNetworks;

  /// Конвертировать объект в JSON-формат.
  Map<String, Object?> toJson() => <String, Object?>{
        'allowed_card_networks': allowedCardNetworks
            .map((GooglePayCardNetwork e) => e.name)
            .toList(growable: false),
      };
}
