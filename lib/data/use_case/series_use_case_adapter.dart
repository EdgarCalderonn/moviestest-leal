import 'package:injectable/injectable.dart';
import 'package:moviestest/domain/models/episode.dart';
import 'package:moviestest/domain/models/serie.dart';
import 'package:moviestest/domain/repository/series_repository.dart';
import 'package:moviestest/domain/use_case/series_use_case.dart';

@Injectable(as: SeriesUseCase)
class SeriesUseCaseAdapter implements SeriesUseCase {
  SeriesUseCaseAdapter(this.repository);

  final SeriesRepository repository;

  @override
  Future<List<Serie>> getPopular({int page = 1}) {
    return repository.getPopular(page: page);
  }
  
  @override
  Future<List<Serie>> getRecommendations({int page = 1}) {
    return repository.getRecommendations(page: page);
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
  Future<List<Episode>> getEpisodes({required int serieId, required int seasonNumber}) {
    return repository.getEpisodes(serieId: serieId, seasonNumber: seasonNumber);
  }
}
