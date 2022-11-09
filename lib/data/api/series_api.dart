import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:moviestest/domain/models/episode.dart';
import 'package:moviestest/domain/models/serie.dart';
import 'package:http/http.dart' as http;

abstract class SeriesApi {
  Future<List<Serie>> getPopular({int page = 1});
  Future<List<Serie>> getRecommendations({int page = 1});
  Future<Serie> getSerie(String serieId);
  Future<List<Season>> getSeasons(int seasonNumber);
  Future<List<Episode>> getEpisodes(
      {required int serieId, required int seasonNumber});
}

@Injectable(as: SeriesApi)
class SeriesApiAdapter implements SeriesApi {
  static const String apiKey = '64b873fd66dc4231fbdba99c23b3ce88';

  @override
  Future<List<Serie>> getPopular({int page = 1}) async {
    http.Response response = await http.get(
      Uri.https(
        'api.themoviedb.org',
        '/3/tv/popular',
        {
          'api_key': apiKey,
          'page': page.toString(),
        },
      ),
    );

    final List<Serie> populars =
        (jsonDecode(response.body)['results'] as List<dynamic>)
            .map((e) => Serie.fromJson(e))
            .toList();

    return populars;
  }

  @override
  Future<List<Serie>> getRecommendations({int page = 1}) async {
    http.Response response = await http.get(
      Uri.https(
        'api.themoviedb.org',
        '/3/tv/top_rated',
        {
          'api_key': apiKey,
          'page': page.toString(),
        },
      ),
    );

    final List<Serie> recommendations =
        (jsonDecode(response.body)['results'] as List<dynamic>)
            .map((e) => Serie.fromJson(e))
            .toList();

    return recommendations;
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
      {required int serieId, required int seasonNumber}) async {
    http.Response response = await http.get(
      Uri.https(
        'api.themoviedb.org',
        '/3/tv/$serieId/season/$seasonNumber',
        {
          'api_key': apiKey,
        },
      ),
    );

    final List<Episode> episodes =
        (jsonDecode(response.body)['episodes'] as List<dynamic>)
            .map((e) => Episode.fromJson(e))
            .toList();

    return episodes;
  }
}
