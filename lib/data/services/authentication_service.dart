import 'package:injectable/injectable.dart';
import 'package:moviestest/data/models/login_credential.dart';
import 'package:moviestest/domain/repository/authentication_repository.dart';

@Injectable(as: AuthenticationRepository)
class AuthenticationService implements AuthenticationRepository {
  @override
  Future<bool> login(String email, String password) async {
    final List<LoginCredential> validCredentials = [
      LoginCredential('maria', 'password'),
      LoginCredential('pedro', '123456'),
    ];

    return validCredentials.contains(LoginCredential(email, password));
  }

  @override
  Future<bool> logout() async {
    return true;
  }
}
