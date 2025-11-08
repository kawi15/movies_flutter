part of 'movie_details_bloc.dart';

abstract class MovieDetailsState {}

class MovieDetailsInitial extends MovieDetailsState {}
class MovieDetailsLoading extends MovieDetailsState {}
class MovieDetailsLoaded extends MovieDetailsState {
  final MovieModel movie;
  MovieDetailsLoaded(this.movie);
}
class MovieDetailsError extends MovieDetailsState {
  final String message;
  MovieDetailsError(this.message);
}
