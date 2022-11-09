import 'package:injectable/injectable.dart';
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
}