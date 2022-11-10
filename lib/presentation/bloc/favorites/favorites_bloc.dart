import 'package:injectable/injectable.dart';
import 'package:moviestest/domain/models/serie.dart';
import 'package:moviestest/domain/use_case/series_use_case.dart';
import 'package:moviestest/presentation/bloc/provider/bloc.dart';
import 'package:rxdart/streams.dart';
import 'package:rxdart/subjects.dart';

@injectable
class FavoritesBloc extends Bloc {
  FavoritesBloc(this._seriesUseCase);

  final SeriesUseCase _seriesUseCase;

  final BehaviorSubject<List<Serie>> _favoriteSeriesSubject =
      BehaviorSubject<List<Serie>>.seeded([]);
  ValueStream<List<Serie>> get favoriteSeriesStream =>
      _favoriteSeriesSubject.stream;

  void addFavorite(Serie serie) {
    if (canAdd(serie.id!)) {
      _favoriteSeriesSubject.value = [..._favoriteSeriesSubject.value, serie];
    } else {
      _favoriteSeriesSubject.value
          .removeWhere((element) => element.id == serie.id);
      _favoriteSeriesSubject.value = _favoriteSeriesSubject.value;
    }
  }

  bool canAdd(int serieId) {
    return _favoriteSeriesSubject.value
            .indexWhere((element) => element.id == serieId) ==
        -1;
  }

  @override
  void dispose() {}
}
