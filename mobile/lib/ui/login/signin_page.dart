import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:raspi_ctrl_app/ui/login/signin_view_model.dart';

class SignInPage extends StatelessWidget {
  static const routerName = 'signin';
  static const routerPath = '/sgnin';

  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(AppLocalizations.of(context)!.signin),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _signInEmail(context),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 30),
              child: const Text(
                'otherwise...',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            _googleSignIn(context),
          ],
        ),
      ),
    );
  }

  Widget _signInEmail(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.pink),
          borderRadius: BorderRadius.circular(10)),
      child: Consumer(
        builder: (context, ref, parent) {
          final vmFunction = ref.read(signinViewModelProvider.notifier);
          final vmState = ref.watch(signinViewModelProvider);
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              children: [
                Text(
                  AppLocalizations.of(context)!.signin_with_email_msg,
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
                    vmFunction.validate(SignInFieldType.email);
                  },
                ),
                TextFormField(
                  controller: vmState.password.controller,
                  decoration: InputDecoration(
                    label: Text(AppLocalizations.of(context)!.password),
                    suffixIcon: _obscureIcon(
                      vmState.password.obscureText,
                      () {
                        vmFunction.toggleObscure(SignInFieldType.password);
                      },
                    ),
                    errorText: vmState.password.errorMessage,
                  ),
                  obscureText: vmState.password.obscureText,
                  onChanged: (_) {
                    vmFunction.validate(SignInFieldType.password);
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
                  child: Text(AppLocalizations.of(context)!.signin),
                ),
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

  Widget _googleSignIn(BuildContext context) {
    return Consumer(builder: (context, ref, parent) {
      return ElevatedButton(
        onPressed: () {
          ref.read(signinViewModelProvider.notifier).signInGoogle();
        },
        child: Text(AppLocalizations.of(context)!.signin_with_google),
      );
    });
  }
}
