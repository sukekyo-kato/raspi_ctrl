import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignupPage extends StatelessWidget {
  static const routerName = 'signup';
  static const routerPath = '/signup';

  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Container(),
    );
  }
}
