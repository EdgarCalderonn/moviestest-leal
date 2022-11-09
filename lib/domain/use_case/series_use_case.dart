import 'package:moviestest/domain/models/episode.dart';
import 'package:moviestest/domain/models/serie.dart';

abstract class SeriesUseCase {
  Future<List<Serie>> getPopular({int page = 1});
  Future<List<Serie>> getRecommendations({int page = 1});
  Future<Serie> getSerie(String serieId);
  Future<List<Season>> getSeasons(int seasonNumber);
  Future<List<Episode>> getEpisodes(
      {required int serieId, required int seasonNumber});
}
