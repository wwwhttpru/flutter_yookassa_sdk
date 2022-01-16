import 'package:equatable/equatable.dart';
import 'package:flutter_yookassa_sdk/src/models/misc/payment_method_types.dart';
import 'package:meta/meta.dart';

/// {@macro tokenization_settings}
@immutable
class TokenizationSettings extends Equatable {
  /// {@template tokenization_settings}
  /// Можно настроить список способов оплаты и
  /// отображение логотипа ЮKassa в приложении.
  /// {@endtemplate}
  const TokenizationSettings({
    this.paymentMethodTypes = const PaymentMethodTypes.all(),
    this.showYooKassaLogo = true,
  });

  /// По умолчанию [PaymentMethodTypes.all].
  /// {@macro payment_method_types}
  final PaymentMethodTypes paymentMethodTypes;

  /// По умолчанию true. Отвечает за отображение логотипа ЮKassa.
  /// По умолчанию логотип отображается.
  final bool showYooKassaLogo;

  Map<String, Object?> toJson() => <String, Object?>{
        'paymentMethodTypes': paymentMethodTypes.toJson(),
        'showYooKassaLogo': showYooKassaLogo,
      };

  @override
  List<Object?> get props => [paymentMethodTypes.props, showYooKassaLogo];
}
