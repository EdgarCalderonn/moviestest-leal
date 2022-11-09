import 'package:moviestest/domain/models/auth_status.dart';

abstract class AuthenticationUseCase {
  Future<bool> login(String email, String password);
  Future<bool> logout();
  Stream<AuthStatus> authStatusStream();
}
