import 'package:injectable/injectable.dart';
import 'package:moviestest/data/api/series_api.dart';
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
}
