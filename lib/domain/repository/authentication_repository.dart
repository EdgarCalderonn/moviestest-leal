abstract class AuthenticationRepository {
  Future<bool> login(String email, String password);
  Future<bool> logout();
}
