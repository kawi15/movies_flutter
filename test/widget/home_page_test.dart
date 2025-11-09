import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/presentation/blocs/search_movies/search_movies_bloc.dart';
import 'package:movies/presentation/blocs/movie_details/movie_details_bloc.dart';
import 'package:movies/data/models/movie_model.dart';
import 'package:movies/presentation/views/home.dart';

class MockSearchMoviesBloc
    extends MockBloc<SearchMoviesEvent, SearchMoviesState> implements SearchMoviesBloc {}

class MockMovieDetailsBloc
    extends MockBloc<MovieDetailsEvent, MovieDetailsState> implements MovieDetailsBloc {}

void main() {
  late MockSearchMoviesBloc searchBloc;
  late MockMovieDetailsBloc detailsBloc;

  setUp(() {
    searchBloc = MockSearchMoviesBloc();
    detailsBloc = MockMovieDetailsBloc();
  });

  Widget makeTestableWidget() {
    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider<SearchMoviesBloc>.value(value: searchBloc),
          BlocProvider<MovieDetailsBloc>.value(value: detailsBloc),
        ],
        child: const HomePage(),
      ),
    );
  }

  testWidgets('shows info text initially', (tester) async {
    when(() => searchBloc.state).thenReturn(SearchMoviesInitial());

    await tester.pumpWidget(makeTestableWidget());

    expect(find.text('Search for a movie'), findsOneWidget);
  });

  testWidgets('shows loading indicator when loading', (tester) async {
    when(() => searchBloc.state).thenReturn(SearchMoviesLoading());

    await tester.pumpWidget(makeTestableWidget());

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('shows movie list when loaded', (tester) async {
    final movies = List.generate(
      3,
          (i) => MovieModel(
        id: i,
        title: 'Movie $i',
        releaseDate: '2020-01-0${i + 1}',
        posterPath: '/path.jpg',
      ),
    );

    when(() => searchBloc.state)
        .thenReturn(SearchMoviesLoaded(movies, hasMore: false));

    await tester.pumpWidget(makeTestableWidget());

    expect(find.text('Movie 0'), findsOneWidget);
    expect(find.text('Movie 1'), findsOneWidget);
    expect(find.text('Movie 2'), findsOneWidget);
  });

  testWidgets('shows error message when error occurs', (tester) async {
    when(() => searchBloc.state)
        .thenReturn(SearchMoviesError('Invalid API key'));

    await tester.pumpWidget(makeTestableWidget());

    expect(find.text('Invalid API key'), findsOneWidget);
  });
}
