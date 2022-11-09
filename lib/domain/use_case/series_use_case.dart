import 'package:moviestest/domain/models/serie.dart';

abstract class SeriesUseCase {
  Future<List<Serie>> getPopular({int page = 1});
}
