import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:raspi_ctrl_app/ui/login/state/field.dart';

part 'signup_state.freezed.dart';

@freezed
class SignUpState with _$SignUpState {
  const SignUpState._();

  const factory SignUpState({
    required Field email,
    required Field password,
    required Field confirmPassword,
  }) = _SignUpState;

  // freezed に独自関数を追加する
  // https://pub.dev/packages/freezed#adding-getters-and-methods-to-our-models
  bool canSubmit() {
    return [email, password, confirmPassword].every((field) => field.isValid);
  }
}
