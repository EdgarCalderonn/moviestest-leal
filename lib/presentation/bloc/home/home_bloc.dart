import 'package:injectable/injectable.dart';
import 'package:moviestest/domain/models/serie.dart';
import 'package:moviestest/domain/use_case/authentication_use_case.dart';
import 'package:moviestest/domain/use_case/series_use_case.dart';
import 'package:moviestest/presentation/bloc/provider/bloc.dart';
import 'package:rxdart/streams.dart';
import 'package:rxdart/subjects.dart';

@injectable
class HomeBloc extends Bloc {
  final AuthenticationUseCase _authenticationUseCase;
  final SeriesUseCase _seriesUseCase;

  HomeBloc(this._authenticationUseCase, this._seriesUseCase);

  final BehaviorSubject<List<Serie>> _popularSeriesSubject =
      BehaviorSubject<List<Serie>>();

  ValueStream<List<Serie>> get popularSeriesStream =>
      _popularSeriesSubject.stream;

  Future<void> getSeries() async {
    final List<Serie> series = await _seriesUseCase.getPopular();
    _popularSeriesSubject.value = series;
  }

  void logout() {
    _authenticationUseCase.logout();
  }

  @override
  void dispose() {
    _popularSeriesSubject.close();
  }
}
