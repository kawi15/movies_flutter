import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/presentation/blocs/movie_details/movie_details_bloc.dart';
import 'package:movies/data/models/movie_model.dart';
import 'package:movies/presentation/views/movie_details.dart';

class MockMovieDetailsBloc
    extends MockBloc<MovieDetailsEvent, MovieDetailsState>
    implements MovieDetailsBloc {}

void main() {
  late MockMovieDetailsBloc mockBloc;

  setUp(() {
    mockBloc = MockMovieDetailsBloc();
  });

  Widget makeTestableWidget(Widget child) {
    return MaterialApp(
      home: BlocProvider<MovieDetailsBloc>.value(
        value: mockBloc,
        child: child,
      ),
    );
  }

  testWidgets('shows loading indicator when state is loading', (tester) async {
    when(() => mockBloc.state).thenReturn(MovieDetailsLoading());

    await tester.pumpWidget(makeTestableWidget(
      const MovieDetailsPage(movieId: 1),
    ));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('shows movie details when loaded', (tester) async {
    final movie = MovieModel(
      id: 1,
      title: 'Inception',
      posterPath: '/poster.jpg',
      releaseDate: '2010-07-16',
      overview: 'A movie about inception.',
    );

    when(() => mockBloc.state).thenReturn(MovieDetailsLoaded(movie));

    await tester.pumpWidget(makeTestableWidget(
      const MovieDetailsPage(movieId: 1),
    ));

    expect(find.text('Inception'), findsOneWidget);

    expect(find.text('A movie about inception.'), findsOneWidget);

    expect(find.textContaining('📅'), findsOneWidget);

    expect(find.byType(Image), findsOneWidget);
  });

  testWidgets('shows error message when state is error', (tester) async {
    when(() => mockBloc.state)
        .thenReturn(MovieDetailsError('Invalid API key'));

    await tester.pumpWidget(makeTestableWidget(
      const MovieDetailsPage(movieId: 1),
    ));

    expect(find.text('Invalid API key'), findsOneWidget);
  });
}
