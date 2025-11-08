import 'package:dio/dio.dart';
import 'package:tmdb_api/tmdb_api.dart';
import '../../core/exceptions/api_exceptions.dart';
import '../models/movie_model.dart';

class MoviesService {
  final TMDB tmdb;

  MoviesService(this.tmdb);

  Future<List<MovieModel>> searchMovies(String query, {int page = 1}) async {
    try {
      final result = await tmdb.v3.search.queryMovies(query, page: page);
      final list = result['results'] as List<dynamic>;
      return list.map((e) => MovieModel.fromJson(e)).toList();
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw UnauthorizedApiKeyException();
      }
      rethrow;
    }

  }

  Future<MovieModel> getMovieDetails(int id) async {
    final result = await tmdb.v3.movies.getDetails(id);
    return MovieModel.fromJson(result);
  }
}