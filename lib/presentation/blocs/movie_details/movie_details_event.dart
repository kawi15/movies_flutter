part of 'movie_details_bloc.dart';

abstract class MovieDetailsEvent {}

class LoadMovieDetails extends MovieDetailsEvent {
  final int id;
  LoadMovieDetails(this.id);
}
