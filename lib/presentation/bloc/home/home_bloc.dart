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

  final BehaviorSubject<List<Serie>> _recommendedSeriesSubject =
      BehaviorSubject<List<Serie>>();

  ValueStream<List<Serie>> get popularSeriesStream =>
      _popularSeriesSubject.stream;

  ValueStream<List<Serie>> get recommendedSeriesStream =>
      _recommendedSeriesSubject.stream;

  Future<void> getPopularSeries() async {
    final List<Serie> series = await _seriesUseCase.getPopular();
    _popularSeriesSubject.value = series;
  }

    Future<void> getRecommendedSeries() async {
    final List<Serie> series = await _seriesUseCase.getRecommendations();
    _recommendedSeriesSubject.value = series;
  }

  void logout() {
    _authenticationUseCase.logout();
  }

  @override
  void dispose() {
    _popularSeriesSubject.close();
  }
}
