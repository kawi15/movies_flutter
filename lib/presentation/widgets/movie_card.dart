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
          ? Image.network(
        'https://image.tmdb.org/t/p/w92${movie.posterPath}',
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