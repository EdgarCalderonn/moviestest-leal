import 'package:injectable/injectable.dart';
import 'package:moviestest/data/api/series_api.dart';
import 'package:moviestest/domain/models/episode.dart';
import 'package:moviestest/domain/models/serie.dart';
import 'package:moviestest/domain/repository/series_repository.dart';

@Injectable(as: SeriesRepository)
class SeriesService implements SeriesRepository {
  SeriesService(this.api);

  SeriesApi api;

  @override
  Future<List<Serie>> getPopular({int page = 1}) {
    return api.getPopular(page: page);
  }

  @override
  Future<List<Serie>> getRecommendations({int page = 1}) {
    return api.getRecommendations();
  }

  @override
  Future<List<Season>> getSeasons(int seasonNumber) {
    // TODO: implement getSeasons
    throw UnimplementedError();
  }

  @override
  Future<Serie> getSerie(String serieId) {
    // TODO: implement getSerie
    throw UnimplementedError();
  }

  @override
  Future<List<Episode>> getEpisodes(
      {required int serieId, required int seasonNumber}) {
    return api.getEpisodes(serieId: serieId, seasonNumber: seasonNumber);
  }
}
