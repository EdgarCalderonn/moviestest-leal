// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:moviestest/domain/models/auth_status.dart';
import 'package:moviestest/presentation/bloc/login/login_bloc.dart';
import 'package:moviestest/presentation/state/base_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends BaseState<LoginPage, LoginBloc> {
  StreamSubscription? authSubscription;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    subscribeToAuth();
  }

  void subscribeToAuth() {
    authSubscription ??= bloc!.authStatusStream.listen((event) {
      if (event == AuthStatus.LOGGED_IN) {
        Navigator.pop(context);
      }
    });
  }

  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: unfocus,
      child: Scaffold(
        key: const Key('login-page'),
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                key: const Key('email-text-field'),
                keyboardType: TextInputType.emailAddress,
                controller: nameCtrl,
                decoration: const InputDecoration(
                  labelText: 'Nombre de usuario',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                key: const Key('password-text-field'),
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                controller: passwordCtrl,
                decoration: const InputDecoration(
                  labelText: 'Contraseña',
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              StreamBuilder<bool>(
                  stream: bloc!.loadingStream,
                  builder: (context, snapshot) {
                    if (snapshot.data == false) {
                      return SizedBox(
                        key: const Key('login-button'),
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            unfocus();

                            final loginSuccess = await bloc!
                                .login(nameCtrl.text, passwordCtrl.text);

                            if (!(loginSuccess ?? true)) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Login incorrecto')));
                            }
                          },
                          child: const Text('Iniciar sesion'),
                        ),
                      );
                    }

                    return const Center(
                      key: Key('login-button-progress-indicator'),
                      child: CircularProgressIndicator(),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }

  void unfocus() {
    FocusScope.of(context).unfocus();
  }

  @override
  void dispose() {
    super.dispose();
    authSubscription?.cancel();
  }
}
