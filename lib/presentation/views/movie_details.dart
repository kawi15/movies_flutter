import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/movie_details/movie_details_bloc.dart';

class MovieDetailsPage extends StatelessWidget {
  final int movieId;
  const MovieDetailsPage({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Movie Details')),
      body: BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
        builder: (context, state) {
          if (state is MovieDetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MovieDetailsLoaded) {
            final movie = state.movie;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (movie.posterPath != null)
                    Image.network(
                      'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                    ),
                  const SizedBox(height: 12),
                  Text(movie.title,
                      style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: 8),
                  Text(movie.overview ?? 'No description available'),
                ],
              ),
            );
          } else if (state is MovieDetailsError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
