import 'package:injectable/injectable.dart';
import 'package:moviestest/data/models/login_credential.dart';
import 'package:moviestest/domain/models/auth_status.dart';
import 'package:moviestest/domain/repository/authentication_repository.dart';
import 'package:rxdart/subjects.dart';

@Injectable(as: AuthenticationRepository)
class AuthenticationService implements AuthenticationRepository {
  AuthenticationService() {
    initialize();
  }

  Future initialize() async {
    await Future.delayed(const Duration(seconds: 2));
    _authStatusSubject.value = AuthStatus.LOGGED_OUT;
  }

  final BehaviorSubject<AuthStatus> _authStatusSubject =
      BehaviorSubject<AuthStatus>.seeded(AuthStatus.UNINITIALIZED);

  @override
  Future<bool> login(String email, String password) async {
    final List<LoginCredential> validCredentials = [
      LoginCredential('maria', 'password'),
      LoginCredential('pedro', '123456'),
    ];

    final bool loginSuccess =
        validCredentials.contains(LoginCredential(email, password));

    _authStatusSubject.value =
        loginSuccess ? AuthStatus.LOGGED_IN : AuthStatus.LOGGED_OUT;

    return loginSuccess;
  }

  @override
  Future<bool> logout() async {
    _authStatusSubject.value = AuthStatus.LOGGED_OUT;
    return true;
  }

  @override
  Stream<AuthStatus> authStatusStream() {
    return _authStatusSubject.stream;
  }
}
