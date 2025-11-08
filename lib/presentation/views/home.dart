import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/presentation/blocs/movie_details/movie_details_bloc.dart';

import '../blocs/search_movies/search_movies_bloc.dart';
import '../widgets/movie_card.dart';
import 'movie_details.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();


  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        final state = context.read<SearchMoviesBloc>().state;
        if (state is SearchMoviesLoaded && state.hasMore) {
          context.read<SearchMoviesBloc>().add(SearchMoviesNextPage());
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Enter movie title...',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      context.read<SearchMoviesBloc>().add(SearchMoviesStarted(_controller.text));
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: BlocBuilder<SearchMoviesBloc, SearchMoviesState>(
                  builder: (context, state) {
                    if (state is SearchMoviesLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is SearchMoviesLoaded) {
                      return ListView.builder(
                        controller: _scrollController,
                        itemCount: state.movies.length + 1,
                        itemBuilder: (context, index) {
                          if (index == state.movies.length) {
                            return state.hasMore
                                ? const Padding(
                              padding: EdgeInsets.all(12),
                              child: Center(
                                  child: CircularProgressIndicator()),
                            )
                                : const SizedBox.shrink();
                          }

                          final movie = state.movies[index];
                          return MovieCard(
                            movie: movie,
                            onTap: () {
                              context.read<MovieDetailsBloc>().add(LoadMovieDetails(movie.id));
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      MovieDetailsPage(movieId: movie.id),
                                ),
                              );
                            },
                          );
                        },
                      );
                    } else if (state is SearchMoviesError) {
                      return Center(child: Text(state.message));
                    }
                    return const Center(
                      child: Text('Search for a movie'),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
