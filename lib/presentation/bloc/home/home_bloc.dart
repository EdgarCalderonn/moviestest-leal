
import 'package:injectable/injectable.dart';
import 'package:moviestest/domain/use_case/authentication_use_case.dart';
import 'package:moviestest/presentation/bloc/provider/bloc.dart';

@injectable
class HomeBloc extends Bloc {
  final AuthenticationUseCase _authenticationUseCase;

  HomeBloc(this._authenticationUseCase);

  void logout(){
    _authenticationUseCase.logout();
  }


  @override
  void dispose() {}
}