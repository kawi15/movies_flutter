import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/movie_model.dart';
import '../../../data/repositories/movies_repository.dart';

part 'search_movies_event.dart';
part 'search_movies_state.dart';

class SearchMoviesBloc extends Bloc<SearchMoviesEvent, SearchMoviesState> {
  final MoviesRepository repository;

  int _currentPage = 1;
  bool _isLoadingMore = false;
  String _currentQuery = '';
  final List<MovieModel> _movies = [];

  SearchMoviesBloc(this.repository) : super(SearchMoviesInitial()) {
    on<SearchMoviesStarted>((event, emit) async {
      emit(SearchMoviesLoading());
      _currentPage = 1;
      _currentQuery = event.query;
      _movies.clear();

      try {
        final results =
        await repository.searchMovies(event.query, page: _currentPage);
        _movies.addAll(results);
        emit(SearchMoviesLoaded(List.from(_movies), hasMore: results.isNotEmpty));
      } catch (e) {
        emit(SearchMoviesError(e.toString()));
      }
    });

    on<SearchMoviesNextPage>((event, emit) async {
      if (_isLoadingMore || _currentQuery.isEmpty) return;
      _isLoadingMore = true;
      _currentPage++;

      try {
        final results =
        await repository.searchMovies(_currentQuery, page: _currentPage);
        if (results.isNotEmpty) {
          _movies.addAll(results);
          emit(SearchMoviesLoaded(List.from(_movies), hasMore: true));
        } else {
          emit(SearchMoviesLoaded(List.from(_movies), hasMore: false));
        }
      } catch (e) {
        emit(SearchMoviesError(e.toString()));
      }

      _isLoadingMore = false;
    });
  }
}
