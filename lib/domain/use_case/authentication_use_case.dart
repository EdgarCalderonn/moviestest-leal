abstract class AuthenticationUseCase {
  Future<bool> login(String email, String password);
  Future<bool> logout();
}
