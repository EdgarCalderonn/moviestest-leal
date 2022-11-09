import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:moviestest/domain/models/serie.dart';
import 'package:http/http.dart' as http;

abstract class SeriesApi {
  Future<List<Serie>> getPopular({int page = 1});
}

@Injectable(as: SeriesApi)
class SeriesApiAdapter implements SeriesApi {
  static const String apiKey = '64b873fd66dc4231fbdba99c23b3ce88';

  @override
  Future<List<Serie>> getPopular({int page = 1}) async {
    http.Response response =
        await http.get(Uri.https('api.themoviedb.org', '/3/tv/popular', {
      'api_key': apiKey,
      'page': page.toString(),
    }));

    final List<Serie> populars =
        (jsonDecode(response.body)['results'] as List<dynamic>)
            .map((e) => Serie.fromJson(e))
            .toList();

    return populars;
  }
}
