import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/movie_model.dart';
import '../../../data/repositories/movies_repository.dart';

part 'movie_details_event.dart';
part 'movie_details_state.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  final MoviesRepository repository;

  MovieDetailsBloc(this.repository) : super(MovieDetailsInitial()) {
    on<LoadMovieDetails>((event, emit) async {
      emit(MovieDetailsLoading());
      try {
        final movie = await repository.getMovieDetails(event.id);
        emit(MovieDetailsLoaded(movie));
      } catch (e) {
        emit(MovieDetailsError(e.toString()));
      }
    });
  }
}
