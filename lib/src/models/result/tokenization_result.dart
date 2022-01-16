import 'dart:core';

import 'package:equatable/equatable.dart';
import 'package:flutter_yookassa_sdk/src/models/result/payment_data.dart';
import 'package:meta/meta.dart';

/// {@macro tokenization_result}
@internal
@immutable
class TokenizationResult extends Equatable {
  /// {@template tokenization_result}
  /// Результат взаимодействия с Юкассой
  /// {@endtemplate}
  const TokenizationResult({
    required this.success,
    this.data,
    this.error,
  });

  /// Если true результат успешный, иначе ошибка false
  final bool success;

  /// Токен и способ оплаты
  /// {@macro payment_data}
  final PaymentData? data;

  /// Описание ошибки
  final String? error;

  Map<String, Object?> toJson() => <String, Object?>{
        'success': success,
        'data': data?.toJson(),
        'error': error,
      };

  @override
  String toString() =>
      'TokenizationResult(success: $success, data: $data, error: $error)';

  @override
  List<Object?> get props => [success, data?.props, error];
}

@internal
@immutable
class TokenizationResultModel extends TokenizationResult {
  const TokenizationResultModel({
    required bool success,
    PaymentData? data,
    String? error,
  }) : super(
          success: success,
          data: data,
          error: error,
        );

  factory TokenizationResultModel.fromJson(Map<String, Object?> json) {
    PaymentData? data;
    if (json['data'] != null) {
      final dataArgs = json['data']! as Map<Object?, Object?>;
      data = PaymentDataModel.fromJson(dataArgs.cast<String, Object?>());
    }
    return TokenizationResultModel(
      success: json['success']! as bool,
      data: data,
      error: json['error'] as String?,
    );
  }
}
