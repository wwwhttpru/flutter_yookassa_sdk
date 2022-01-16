import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

/// {@macro confirm_checkout_module_input_data}
@internal
@immutable
class ConfirmCheckoutModuleInputData extends Equatable {
  /// {@template confirm_checkout_module_input_data}
  /// Входные данные для повторной токенизации банковской карты.
  /// {@endtemplate}
  const ConfirmCheckoutModuleInputData({
    required this.confirmationUrl,
    required this.paymentMethodType,
  });

  /// Ссылка для подтверждения 3DS, которую сообщил наш сервер
  final String confirmationUrl;

  /// {@macro payment_method_type}
  final String paymentMethodType;

  Map<String, Object?> toJson() => {
        'confirmationUrl': confirmationUrl,
        'paymentMethodType': paymentMethodType,
      };

  @override
  String toString() => 'ConfirmCheckoutModuleInputData('
      'confirmationUrl: $confirmationUrl, '
      'paymentMethodType: $paymentMethodType)';

  @override
  List<Object?> get props => [confirmationUrl, paymentMethodType];
}

@internal
@immutable
class ConfirmCheckoutModuleInputDataModel
    extends ConfirmCheckoutModuleInputData {
  const ConfirmCheckoutModuleInputDataModel({
    required String confirmationUrl,
    required String paymentMethodType,
  }) : super(
          confirmationUrl: confirmationUrl,
          paymentMethodType: paymentMethodType,
        );

  factory ConfirmCheckoutModuleInputDataModel.fromJson(
    Map<String, Object?> json,
  ) =>
      ConfirmCheckoutModuleInputDataModel(
        confirmationUrl: json['confirmationUrl']! as String,
        paymentMethodType: json['paymentMethodType']! as String,
      );
}
