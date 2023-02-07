import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:raspi_ctrl_app/gen/assets/assets.gen.dart';
import 'package:raspi_ctrl_app/ui/app.dart';
import 'package:raspi_ctrl_app/ui/login/signup_page.dart';

class LaunchPage extends StatelessWidget {
  static const routerName = 'launch';
  static const routerPath = '/launch';

  const LaunchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _title(context),
              _logo(context),
              _signIn(context),
              _agreement(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _title(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.title,
      style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
    );
  }

  Widget _logo(BuildContext context) {
    return Assets.images.raspiImage.image(width: 250, height: 250);
  }

  Widget _signIn(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          context.push(SignupPage.routerPath);
        },
        child: Text(AppLocalizations.of(context)!.get_started));
  }

  Widget _agreement(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          const TextSpan(
              text: 'xxxxxxxxxx.', style: TextStyle(color: Colors.black)),

          // https://stackoverflow.com/questions/43583411/how-to-create-a-hyperlink-in-flutter-widget
          TextSpan(
              text: 'yyyyyyyyyy.',
              style: const TextStyle(
                  color: Colors.blue, decoration: TextDecoration.underline),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  scaffoldKey.currentState!.showSnackBar(
                    const SnackBar(
                      content: Text('tap link.'),
                    ),
                  );
                }),
          const TextSpan(
              text: 'zzzzzzzzzz.', style: TextStyle(color: Colors.black)),
        ],
      ),
    );
  }
}
