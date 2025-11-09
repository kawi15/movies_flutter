import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/data/repositories/movies_repository.dart';
import 'package:movies/data/models/movie_model.dart';
import 'package:movies/data/services/movies_service.dart';
import 'package:movies/core/exceptions/api_exceptions.dart';

class MockMoviesService extends Mock implements MoviesService {}

void main() {
  late MoviesRepository repository;
  late MockMoviesService mockMoviesService;

  setUp(() {
    mockMoviesService = MockMoviesService();
    repository = MoviesRepository(mockMoviesService);
  });

  final movie = MovieModel(id: 1, title: 'Inception', releaseDate: '2010-07-16');

  group('MoviesRepository', () {
    test('should return list of movies when searchMovies succeeds', () async {
      // Arrange
      when(() => mockMoviesService.searchMovies(any(), page: any(named: 'page')))
          .thenAnswer((_) async => [movie]);

      // Act
      final result = await repository.searchMovies('Inception');

      // Assert
      expect(result, isA<List<MovieModel>>());
      expect(result.length, 1);
      expect(result.first.title, equals('Inception'));
      verify(() => mockMoviesService.searchMovies('Inception', page: 1)).called(1);
    });

    test('should throw UnauthorizedApiKeyException when MoviesService throws it', () async {
      // Arrange
      when(() => mockMoviesService.searchMovies(any(), page: any(named: 'page')))
          .thenThrow(UnauthorizedApiKeyException());

      // Act + Assert
      expect(
            () => repository.searchMovies('test'),
        throwsA(isA<UnauthorizedApiKeyException>()),
      );
    });

    test('should call getMovieDetails and return MovieModel', () async {
      // Arrange
      when(() => mockMoviesService.getMovieDetails(any()))
          .thenAnswer((_) async => movie);

      // Act
      final result = await repository.getMovieDetails(1);

      // Assert
      expect(result, isA<MovieModel>());
      expect(result.title, equals('Inception'));
      verify(() => mockMoviesService.getMovieDetails(1)).called(1);
    });
  });
}
