import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:raspi_ctrl_app/ui/login/state/field.dart';
import 'package:raspi_ctrl_app/ui/login/state/signin_state.dart';

enum SignInFieldType {
  email,
  password,
}

final signinViewModelProvider =
    StateNotifierProvider.autoDispose<SignInViewModel, SignInState>(
        (ref) => SignInViewModel(ref));

class SignInViewModel extends StateNotifier<SignInState> {
  final Ref _ref;

  SignInViewModel(this._ref)
      : super(
          SignInState(
            email: Field(text: 'email', controller: TextEditingController()),
            password:
                Field(text: 'password', controller: TextEditingController()),
          ),
        );

  void toggleObscure(SignInFieldType type) {
    switch (type) {
      case SignInFieldType.email:
        // not effect.
        break;
      case SignInFieldType.password:
        state = state.copyWith(
            password: state.password
                .copyWith(obscureText: !state.password.obscureText));
        break;
      default:
        throw Exception("Undefined validate type.");
    }
  }

  void validate(SignInFieldType type) {
    switch (type) {
      case SignInFieldType.email:
        _validateMail();
        break;
      case SignInFieldType.password:
        // not effect.
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

  void submit() {}

  void signInGoogle() {}
}
