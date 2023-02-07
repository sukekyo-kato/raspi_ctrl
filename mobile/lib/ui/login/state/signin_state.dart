import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:raspi_ctrl_app/ui/login/state/field.dart';

part 'signin_state.freezed.dart';

@freezed
class SignInState with _$SignInState {
  const SignInState._();

  const factory SignInState({
    required Field email,
    required Field password,
  }) = _SignInState;

  // freezed に独自関数を追加する
  // https://pub.dev/packages/freezed#adding-getters-and-methods-to-our-models
  bool canSubmit() {
    return [email, password].every((field) => field.isValid);
  }
}
