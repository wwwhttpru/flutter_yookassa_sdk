import 'package:flutter_yookassa_sdk/src/models/help/help.dart';
import 'package:meta/meta.dart';

/// {@template google_pay_card_network}
/// Платежные системы, через которые возможна оплата с помощью Google Pay.
/// {@endtemplate}
enum GooglePayCardNetwork {
  /// AMEX
  amex,

  /// DISCOVER
  discover,

  /// JCB
  jcb,

  /// MASTERCARD
  mastercard,

  /// VISA
  visa,

  /// INTERAC
  interac,

  /// OTHER
  other,
}

// ignore: avoid_classes_with_only_static_members
@immutable
@internal
class GooglePayCardNetworkModel {
  const GooglePayCardNetworkModel._();

  static GooglePayCardNetwork decode(Object? source) =>
      enumDecode<GooglePayCardNetwork, String>(
        googlePayCardNetworkEnumMap,
        source,
      );

  static String encode(GooglePayCardNetwork source) {
    final value = googlePayCardNetworkEnumMap[source];
    if (value == null) {
      throw ArgumentError(
        '`$source` is not one of the supported values: '
        '${googlePayCardNetworkEnumMap.values.join(', ')}',
      );
    }
    return value;
  }

  static const Map<GooglePayCardNetwork, String> googlePayCardNetworkEnumMap = {
    GooglePayCardNetwork.amex: 'AMEX',
    GooglePayCardNetwork.discover: 'DISCOVER',
    GooglePayCardNetwork.jcb: 'JCB',
    GooglePayCardNetwork.mastercard: 'MASTERCARD',
    GooglePayCardNetwork.visa: 'VISA',
    GooglePayCardNetwork.interac: 'INTERAC',
    GooglePayCardNetwork.other: 'OTHER',
  };
}
