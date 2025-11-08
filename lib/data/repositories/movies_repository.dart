import 'package:movies/data/services/movies_service.dart';

import '../models/movie_model.dart';

class MoviesRepository {
  final MoviesService moviesService;

  MoviesRepository(this.moviesService);

  Future<List<MovieModel>> searchMovies(String query, {int page = 1}) =>
      moviesService.searchMovies(query, page: page);

  Future<MovieModel> getMovieDetails(int id) =>
      moviesService.getMovieDetails(id);
}