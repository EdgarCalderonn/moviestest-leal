import 'package:injectable/injectable.dart';
import 'package:moviestest/domain/models/episode.dart';
import 'package:moviestest/domain/use_case/series_use_case.dart';
import 'package:moviestest/presentation/bloc/provider/bloc.dart';
import 'package:rxdart/streams.dart';
import 'package:rxdart/subjects.dart';

@injectable
class SerieDetailBloc extends Bloc {
  SerieDetailBloc(this._seriesUseCase);

  final SeriesUseCase _seriesUseCase;

  final BehaviorSubject<List<Episode>> _episodesSubject =
      BehaviorSubject<List<Episode>>();

  final BehaviorSubject<int> _currentEpisodeIndexSubject =
      BehaviorSubject<int>.seeded(0);

  ValueStream<List<Episode>> get episodesStream => _episodesSubject.stream;
  ValueStream<int> get urrentEpisodeIndexStream =>
      _currentEpisodeIndexSubject.stream;

  Stream<SerieEpisodesInfo> get episodesInfoStream =>
      CombineLatestStream.combine2<List<Episode>, int, SerieEpisodesInfo>(
          _episodesSubject,
          _currentEpisodeIndexSubject,
          (a, b) => SerieEpisodesInfo(episodes: a, selectedEpisode: b));

  Future<void> getEpisodes(int serieId, int seasonNumber) async {
    _episodesSubject.value = await _seriesUseCase.getEpisodes(
        serieId: serieId, seasonNumber: seasonNumber);
  }

  void goToNextEpisode() {
    if (_currentEpisodeIndexSubject.value < _episodesSubject.value.length - 1) {
      _currentEpisodeIndexSubject.value = _currentEpisodeIndexSubject.value + 1;
    }
  }

  @override
  void dispose() {
    _episodesSubject.close();
  }
}

class SerieEpisodesInfo {
  List<Episode>? episodes;
  int? selectedEpisode;

  SerieEpisodesInfo({required this.episodes, required this.selectedEpisode});
}
