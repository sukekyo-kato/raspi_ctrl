import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'field.freezed.dart';

@freezed
class Field with _$Field {
  factory Field({
    required String text,
    required TextEditingController controller,
    @Default('') String errorMessage,
    @Default(false) bool isValid,
    @Default(true) bool obscureText,
  }) = _Field;
}
