import 'package:tmdb_api/tmdb_api.dart';
import '../models/movie_model.dart';

class MoviesService {
  final TMDB tmdb;

  MoviesService(this.tmdb);

  Future<List<MovieModel>> searchMovies(String query, {int page = 1}) async {
    final result = await tmdb.v3.search.queryMovies(query, page: page);
    final list = result['results'] as List<dynamic>;
    return list.map((e) => MovieModel.fromJson(e)).toList();
  }

  Future<MovieModel> getMovieDetails(int id) async {
    final result = await tmdb.v3.movies.getDetails(id);
    return MovieModel.fromJson(result);
  }
}