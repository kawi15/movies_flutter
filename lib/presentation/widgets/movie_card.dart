import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies/core/theme/text_styles.dart';
import '../../../data/models/movie_model.dart';
import '../../core/utils/release_date_formatter.dart';

class MovieCard extends StatelessWidget {
  final MovieModel movie;
  final VoidCallback onTap;

  const MovieCard({
    super.key,
    required this.movie,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 2,
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              child: movie.posterPath != null
                  ? CachedNetworkImage(
                imageUrl:
                'https://image.tmdb.org/t/p/w154${movie.posterPath}',
                width: 100,
                height: 150,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  width: 100,
                  height: 150,
                  color: Colors.grey[300],
                  child: const Center(
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  width: 100,
                  height: 150,
                  color: Colors.grey[300],
                  child: const Icon(Icons.broken_image, size: 40),
                ),
              )
                  : Container(
                width: 100,
                height: 150,
                color: Colors.grey[300],
                child: const Icon(Icons.movie, size: 40),
              ),
            ),

            Expanded(
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: AppTextStyles.listTitle
                    ),
                    const SizedBox(height: 8),
                    Text(
                      formatReleaseDate(movie.releaseDate),
                      style: AppTextStyles.listDate,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
