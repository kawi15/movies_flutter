import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:movies/presentation/blocs/movie_details/movie_details_bloc.dart';
import 'package:movies/data/models/movie_model.dart';
import 'package:movies/data/repositories/movies_repository.dart';

class MockMoviesRepository extends Mock implements MoviesRepository {}

void main() {
  late MovieDetailsBloc bloc;
  late MockMoviesRepository repository;

  setUp(() {
    repository = MockMoviesRepository();
    bloc = MovieDetailsBloc(repository);
  });

  final movie = MovieModel(id: 1, title: 'Inception');

  blocTest<MovieDetailsBloc, MovieDetailsState>(
    'emits [Loading, Loaded] when movie details are fetched',
    build: () {
      when(() => repository.getMovieDetails(1))
          .thenAnswer((_) async => movie);
      return bloc;
    },
    act: (bloc) => bloc.add(LoadMovieDetails(1)),
    expect: () => [
      isA<MovieDetailsLoading>(),
      isA<MovieDetailsLoaded>(),
    ],
  );

  blocTest<MovieDetailsBloc, MovieDetailsState>(
    'emits [Loading, Error] when fetching fails',
    build: () {
      when(() => repository.getMovieDetails(1))
          .thenThrow(Exception('Not found'));
      return bloc;
    },
    act: (bloc) => bloc.add(LoadMovieDetails(1)),
    expect: () => [
      isA<MovieDetailsLoading>(),
      isA<MovieDetailsError>(),
    ],
  );
}
