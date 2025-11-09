import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies/presentation/widgets/movie_card.dart';
import 'package:movies/data/models/movie_model.dart';

void main() {
  group('MovieCard widget', () {
    late MovieModel movie;
    late MovieModel movieWithoutPoster;
    late bool tapped;

    setUp(() {
      tapped = false;
      movie = MovieModel(
        id: 1,
        title: 'Inception',
        posterPath: '/poster.jpg',
        releaseDate: '2010-07-16',
      );
      movieWithoutPoster = MovieModel(
        id: 1,
        title: 'Inception',
        releaseDate: '2010-07-16',
      );
    });

    testWidgets('displays movie title and formatted release date',
            (WidgetTester tester) async {
          await tester.pumpWidget(
            MaterialApp(
              home: Scaffold(
                body: MovieCard(
                  movie: movie,
                  onTap: () {},
                ),
              ),
            ),
          );

          expect(find.text('Inception'), findsOneWidget);

          expect(find.text('16 July 2010'), findsOneWidget);

          expect(find.byType(Image), findsOneWidget);
        });

    testWidgets('shows placeholder when posterPath is null',
            (WidgetTester tester) async {

          await tester.pumpWidget(
            MaterialApp(
              home: Scaffold(
                body: MovieCard(
                  movie: movieWithoutPoster,
                  onTap: () {},
                ),
              ),
            ),
          );

          expect(find.byIcon(Icons.movie), findsOneWidget);
        });

    testWidgets('calls onTap when tapped', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MovieCard(
              movie: movie,
              onTap: () {
                tapped = true;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byType(MovieCard));
      await tester.pump(Duration(seconds: 5));

      expect(tapped, isTrue);
    });
  });
}
