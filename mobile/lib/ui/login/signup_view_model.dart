import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:raspi_ctrl_app/ui/login/state/field.dart';
import 'package:raspi_ctrl_app/ui/login/state/signup_state.dart';

enum SignUpFieldType {
  email,
  password,
  confirmPassword,
}

final signupViewModelProvider =
    StateNotifierProvider.autoDispose<SignupViewModel, SignUpState>(
        (ref) => SignupViewModel(ref));

class SignupViewModel extends StateNotifier<SignUpState> {
  final Ref _ref;

  SignupViewModel(this._ref)
      : super(
          SignUpState(
            email: Field(text: 'email', controller: TextEditingController()),
            password:
                Field(text: 'password', controller: TextEditingController()),
            confirmPassword: Field(
                text: 'confirmpassword', controller: TextEditingController()),
          ),
        );

  void toggleObscure(SignUpFieldType type) {
    switch (type) {
      case SignUpFieldType.email:
        // not effect.
        break;
      case SignUpFieldType.password:
        state = state.copyWith(
            password: state.password
                .copyWith(obscureText: !state.password.obscureText));
        break;
      case SignUpFieldType.confirmPassword:
        state = state.copyWith(
            confirmPassword: state.confirmPassword
                .copyWith(obscureText: !state.confirmPassword.obscureText));
        break;
      default:
        throw Exception("Undefined validate type.");
    }
  }

  void validate(SignUpFieldType type) {
    switch (type) {
      case SignUpFieldType.email:
        _validateMail();
        break;
      case SignUpFieldType.password:
        _validatePassword();
        break;
      case SignUpFieldType.confirmPassword:
        _validateConfirmPassword();
        break;
      default:
        throw Exception("Undefined validate type.");
    }
  }

  void _validateMail() {
    String errorMsg = '';
    final mail = state.email.controller.text;
    final isValid = EmailValidator.validate(mail);

    if (mail.isNotEmpty && !isValid) {
      // TODO: 多言語化.
      errorMsg = '* invalid email.';
    }

    state = state.copyWith(
        email: state.email.copyWith(errorMessage: errorMsg, isValid: isValid));
  }

  void _validatePassword() {
    String errorMsg = '';
    final password = state.password.controller.text;

    // TODO: 厳格化, DDD意識するなら、ドメイン層?.
    final isValid = 7 < password.length && password.length < 21;
    if (password.isNotEmpty && !isValid) {
      errorMsg = '* too short.';
    }
    state = state.copyWith(
        password:
            state.password.copyWith(errorMessage: errorMsg, isValid: isValid));

    // 連動させる
    _validateConfirmPassword();
  }

  void _validateConfirmPassword() {
    String errorMsg = '';
    final password = state.password.controller.text;
    final confirmPassword = state.confirmPassword.controller.text;
    if (confirmPassword.isNotEmpty && password != confirmPassword) {
      errorMsg = '* not match.';
    }
    state = state.copyWith(
        confirmPassword: state.confirmPassword
            .copyWith(errorMessage: errorMsg, isValid: errorMsg.isEmpty));
  }

  void submit() {}

  void signInGoogle() {}
}
