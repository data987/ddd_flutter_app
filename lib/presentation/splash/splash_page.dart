import 'package:auto_route/auto_route.dart';
import 'package:ddd_flutter_app/application/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.map(
          initial: (_) {},
          authenticated: (_) {
            print("I'm authenticated");
          },
          unauthenticated: (_) => context.router.replaceNamed('sign-in-page'),
        );
      },
      child: const Scaffold(
        body: CircularProgressIndicator(),
      ),
    );
  }
}
