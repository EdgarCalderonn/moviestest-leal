import 'package:moviestest/domain/models/serie.dart';

abstract class SeriesRepository {
  Future<List<Serie>> getPopular({int page = 1});
}
