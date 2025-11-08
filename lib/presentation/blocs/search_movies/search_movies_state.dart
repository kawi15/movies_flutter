part of 'search_movies_bloc.dart';

abstract class SearchMoviesState {}

class SearchMoviesInitial extends SearchMoviesState {}
class SearchMoviesLoading extends SearchMoviesState {}

class SearchMoviesLoaded extends SearchMoviesState {
  final List<MovieModel> movies;
  final bool hasMore;

  SearchMoviesLoaded(this.movies, {this.hasMore = true});
}

class SearchMoviesError extends SearchMoviesState {
  final String message;
  SearchMoviesError(this.message);
}
