part of '../models.dart';

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
