import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:raspi_ctrl_app/ui/login/signup_view_model.dart';

class SignUpPage extends StatelessWidget {
  static const routerName = 'signup';
  static const routerPath = '/signup';

  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(AppLocalizations.of(context)!.signup),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _signUpEmail(context),
          ],
        ),
      ),
    );
  }

  Widget _signUpEmail(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.pink),
          borderRadius: BorderRadius.circular(10)),
      child: Consumer(
        builder: (context, ref, parent) {
          final vmFunction = ref.read(signupViewModelProvider.notifier);
          final vmState = ref.watch(signupViewModelProvider);
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              children: [
                Text(
                  AppLocalizations.of(context)!.signup_with_email_msg,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  controller: vmState.email.controller,
                  decoration: InputDecoration(
                    label: Text(AppLocalizations.of(context)!.email),
                    errorText: vmState.email.errorMessage,
                  ),
                  onChanged: (_) {
                    vmFunction.validate(SignUpFieldType.email);
                  },
                ),
                TextFormField(
                  controller: vmState.password.controller,
                  decoration: InputDecoration(
                    label: Text(AppLocalizations.of(context)!.password),
                    suffixIcon: _obscureIcon(
                      vmState.password.obscureText,
                      () {
                        vmFunction.toggleObscure(SignUpFieldType.password);
                      },
                    ),
                    errorText: vmState.password.errorMessage,
                  ),
                  obscureText: vmState.password.obscureText,
                  onChanged: (_) {
                    vmFunction.validate(SignUpFieldType.password);
                  },
                ),
                TextFormField(
                  controller: vmState.confirmPassword.controller,
                  decoration: InputDecoration(
                    label: Text(AppLocalizations.of(context)!.confirm_password),
                    suffixIcon: _obscureIcon(
                      vmState.confirmPassword.obscureText,
                      () {
                        vmFunction
                            .toggleObscure(SignUpFieldType.confirmPassword);
                      },
                    ),
                    errorText: vmState.confirmPassword.errorMessage,
                  ),
                  obscureText: vmState.confirmPassword.obscureText,
                  onChanged: (_) {
                    vmFunction.validate(SignUpFieldType.confirmPassword);
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: vmState.canSubmit()
                        ? () {
                            vmFunction.submit();
                          }
                        : null,
                    child: Text(AppLocalizations.of(context)!.signup)),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _obscureIcon(bool enableObscure, Function()? onPressed) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(enableObscure ? Icons.visibility_off : Icons.visibility),
    );
  }
}
