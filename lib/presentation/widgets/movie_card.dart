import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../data/models/movie_model.dart';

class MovieCard extends StatelessWidget {
  final MovieModel movie;
  final VoidCallback onTap;

  const MovieCard({super.key, required this.movie, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: movie.posterPath != null
          ? CachedNetworkImage(
                  imageUrl: 'https://image.tmdb.org/t/p/w92${movie.posterPath}',
        progressIndicatorBuilder: (context, _, __) => Center(child: CircularProgressIndicator()),
                  width: 50,
                  fit: BoxFit.cover,
                )
          : const Icon(Icons.movie),
      title: Text(movie.title),
      subtitle: Text(movie.releaseDate ?? ''),
      onTap: onTap,
    );
  }
}