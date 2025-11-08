part of 'search_movies_bloc.dart';

abstract class SearchMoviesEvent {}

class SearchMoviesStarted extends SearchMoviesEvent {
  final String query;
  SearchMoviesStarted(this.query);
}

class SearchMoviesNextPage extends SearchMoviesEvent {}
