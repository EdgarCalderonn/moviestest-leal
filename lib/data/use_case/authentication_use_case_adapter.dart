import 'package:injectable/injectable.dart';
import 'package:moviestest/domain/repository/authentication_repository.dart';
import 'package:moviestest/domain/use_case/authentication_use_case.dart';

@Injectable(as: AuthenticationUseCase)
class AuthenticationUseCaseAdapter implements AuthenticationUseCase {
  AuthenticationUseCaseAdapter(this._repository);

  final AuthenticationRepository _repository;

  @override
  Future<bool> login(String email, String password) {
    return _repository.login(email, password);
  }

  @override
  Future<bool> logout() {
    return _repository.logout();
  }
}
