import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/presentation/utils/release_date_formatter.dart';

import '../blocs/movie_details/movie_details_bloc.dart';

class MovieDetailsPage extends StatelessWidget {
  final int movieId;
  const MovieDetailsPage({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Movie details'),
      ),
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
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: CachedNetworkImage(
                          imageUrl: 'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                          placeholder: (context, url) => Container(
                            height: 500,
                            color: Colors.grey[300],
                            child: const Center(
                                child: CircularProgressIndicator()),
                          ),
                          errorWidget: (context, url, error) =>
                              Container(
                                height: 300,
                                color: Colors.grey[300],
                                child: const Icon(Icons.broken_image, size: 50),
                              ),
                        ),
                      ),
                    ),
                  const SizedBox(height: 16),
                  Text(
                    movie.title,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold
                    )
                  ),
                  const SizedBox(height: 8),
                  if (movie.releaseDate != null && movie.releaseDate!.isNotEmpty)
                    Text(
                      '📅 ${formatReleaseDate(movie.releaseDate!)}',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey[600]
                      ),
                    ),
                  const SizedBox(height: 16),
                  Text(
                    movie.overview ?? 'No description available.',
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.5
                    ),
                  )
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
