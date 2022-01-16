import 'package:equatable/equatable.dart';
import 'package:flutter_yookassa_sdk/src/models/misc/google_pay_card_network.dart';
import 'package:meta/meta.dart';

/// {@macro google_pay_parameters}
@immutable
class GooglePayParameters extends Equatable {
  /// {@template google_pay_parameters}
  /// Настройки для оплаты через Google Pay
  /// {@endtemplate}
  const GooglePayParameters({
    this.allowedCardNetworks = const <GooglePayCardNetwork>{
      ...GooglePayCardNetwork.values,
    },
  });

  /// Платежные системы [GooglePayCardNetwork],
  /// через которые возможна оплата с помощью Google Pay.
  final Set<GooglePayCardNetwork> allowedCardNetworks;

  Map<String, Object?> toJson() => <String, Object?>{
        'allowedCardNetworks':
            allowedCardNetworks.map(GooglePayCardNetworkModel.encode).toList(),
      };

  @override
  String toString() =>
      'GooglePayParameters(allowedCardNetworks: $allowedCardNetworks)';

  @override
  List<Object?> get props => [allowedCardNetworks];
}
