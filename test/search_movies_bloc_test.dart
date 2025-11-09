import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:movies/presentation/blocs/search_movies/search_movies_bloc.dart';
import 'package:movies/data/models/movie_model.dart';
import 'package:movies/data/repositories/movies_repository.dart';

class MockMoviesRepository extends Mock implements MoviesRepository {}

void main() {
  late SearchMoviesBloc bloc;
  late MockMoviesRepository repository;

  setUp(() {
    repository = MockMoviesRepository();
    bloc = SearchMoviesBloc(repository);
  });

  final movies = [
    MovieModel(id: 1, title: 'Inception'),
    MovieModel(id: 2, title: 'Interstellar'),
  ];

  blocTest<SearchMoviesBloc, SearchMoviesState>(
    'emits [Loading, Loaded] when movies are fetched successfully',
    build: () {
      when(() => repository.searchMovies(any(), page: any(named: 'page')))
          .thenAnswer((_) async => movies);
      return bloc;
    },
    act: (bloc) => bloc.add(SearchMoviesStarted('Nolan')),
    expect: () => [
      isA<SearchMoviesLoading>(),
      isA<SearchMoviesLoaded>(),
    ],
  );

  blocTest<SearchMoviesBloc, SearchMoviesState>(
    'emits [Loading, Error] when repository throws exception',
    build: () {
      when(() => repository.searchMovies(any(), page: any(named: 'page')))
          .thenThrow(Exception('Network error'));
      return bloc;
    },
    act: (bloc) => bloc.add(SearchMoviesStarted('test')),
    expect: () => [
      isA<SearchMoviesLoading>(),
      isA<SearchMoviesError>(),
    ],
  );
}
