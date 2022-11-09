import 'package:flutter/material.dart';
import 'package:moviestest/domain/models/auth_status.dart';
import 'package:moviestest/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:moviestest/presentation/pages/home/home_page.dart';
import 'package:moviestest/presentation/pages/login/login_page.dart';
import 'package:moviestest/presentation/pages/splash/splash_page.dart';
import 'package:moviestest/presentation/state/base_state.dart';

class AuthenticationWrapper extends StatefulWidget {
  const AuthenticationWrapper({super.key});

  @override
  State<AuthenticationWrapper> createState() => _AuthenticationWrapperState();
}

class _AuthenticationWrapperState
    extends BaseState<AuthenticationWrapper, AuthenticationBloc> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthStatus>(
      stream: bloc!.authStatusStream,
      builder: (BuildContext context, AsyncSnapshot<AuthStatus> snapshot) {
        if (snapshot.hasData) {
          switch (snapshot.data!) {
            case AuthStatus.UNINITIALIZED:
              return const SplashPage();

            case AuthStatus.LOGGED_OUT:
              return const LoginPage();

            case AuthStatus.LOGGED_IN:
              return const HomePage();
          }
        }

        return const SizedBox.shrink();
      },
    );
  }
}
