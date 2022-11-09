import 'package:flutter/material.dart';
import 'package:moviestest/presentation/dependency_injection/injection.dart';
import 'package:moviestest/presentation/pages/authentication/authentication_wrapper.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  configureDependencies();

  runApp(const MaterialApp(
    home: AuthenticationWrapper(),
  ));
}
