import 'package:injectable/injectable.dart';
import 'package:moviestest/domain/models/serie.dart';
import 'package:moviestest/domain/use_case/series_use_case.dart';
import 'package:moviestest/presentation/bloc/provider/bloc.dart';
import 'package:rxdart/streams.dart';
import 'package:rxdart/subjects.dart';

@injectable
class RecentBloc extends Bloc {
  RecentBloc(this._seriesUseCase);

  final SeriesUseCase _seriesUseCase;

  final BehaviorSubject<List<Serie>> _recentSeriesSubject =
      BehaviorSubject<List<Serie>>();
  ValueStream<List<Serie>> get recentSeriesStream =>
      _recentSeriesSubject.stream;

  void loadRecent() async {
    _recentSeriesSubject.value = await _seriesUseCase.getRecent();
  }

  @override
  void dispose() {
    _recentSeriesSubject.close();
  }
}
