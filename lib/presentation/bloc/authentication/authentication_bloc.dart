import 'package:injectable/injectable.dart';
import 'package:moviestest/domain/models/auth_status.dart';
import 'package:moviestest/domain/use_case/authentication_use_case.dart';
import 'package:moviestest/presentation/bloc/provider/bloc.dart';
import 'package:rxdart/streams.dart';
import 'package:rxdart/subjects.dart';

@injectable
class AuthenticationBloc extends Bloc {
  AuthenticationBloc(this._authenticationUseCase);

  final AuthenticationUseCase _authenticationUseCase;

  final BehaviorSubject<bool> _loadingSubject =
      BehaviorSubject<bool>.seeded(false);

  final BehaviorSubject<void> _loginErrorSubject = BehaviorSubject<void>();

  Stream<AuthStatus> get authStatusStream =>
      _authenticationUseCase.authStatusStream();

  ValueStream<bool> get loadingStream => _loadingSubject.stream;
  ValueStream<void> get loginErrorStream => _loginErrorSubject.stream;


  Future<bool?> login(String email, String password) async {
    /// If it is not loading we try to log in
    if (!_loadingSubject.value) {
      _loadingSubject.value = true;

      final bool loginSuccess =
          await _authenticationUseCase.login(email, password);

      if (loginSuccess) {
        _loadingSubject.value = false;
        return true;
      }

      _loadingSubject.value = false;
      return false;
    }

    return null;
  }

  @override
  void dispose() {
    _loadingSubject.close();
  }
}
