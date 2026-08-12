import 'dart:io';

import 'package:flutter/material.dart';
import 'package:movie_app/model/movie_model.dart';
import 'package:movie_app/providers/movie_provider.dart';
import 'package:movie_app/widgets/movie_bottom_sheet.dart';
import 'package:provider/provider.dart';

class MovieCard extends StatelessWidget {
  final MovieModel movie;

  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),

      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) {
            return DraggableScrollableSheet(
              initialChildSize: 0.9,
              minChildSize: 0.5,
              maxChildSize: 0.95,
              expand: false,
              builder: (context, scrollController) {
                return MovieBottomSheet(
                  movie: movie,
                  scrollController: scrollController,
                );
              },
            );
          },
        );
      },

      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(12),
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),

                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Hero(tag: movie.id, child: _buildMovieImage()),

                    Positioned(
                      top: 10,
                      right: 10,

                      child: Consumer<MovieProvider>(
                        builder: (context, provider, child) {
                          final isFav = provider.isFavorite(movie);

                          return GestureDetector(
                            onTap: () {
                              provider.toggleFavorite(movie);
                            },

                            child: Icon(
                              isFav ? Icons.favorite : Icons.favorite_border,
                              color: isFav ? Colors.red : Colors.white,
                              size: 26,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(10),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  // Movie title
                  Text(
                    movie.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,

                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 6),

                  // Year + Rating
                  Row(
                    children: [
                      // Year
                      Expanded(
                        child: Text(
                          movie.year,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,

                          style: const TextStyle(
                            color: Color(0xFFF6C7C7),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      // Rating
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 16),

                          const SizedBox(width: 4),

                          Text(
                            movie.rating,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMovieImage() {
    // API ko image URL
    if (movie.image.startsWith('http')) {
      return Image.network(
        movie.image,
        fit: BoxFit.cover,

        errorBuilder: (context, error, stackTrace) {
          return _errorImage();
        },
      );
    }

    // Gallery bata select gareko local image
    return Image.file(
      File(movie.image),
      fit: BoxFit.cover,

      errorBuilder: (context, error, stackTrace) {
        return _errorImage();
      },
    );
  }

  Widget _errorImage() {
    return Container(
      color: const Color(0xFF2A2A2A),

      child: const Center(
        child: Icon(Icons.movie, color: Colors.white54, size: 50),
      ),
    );
  }
}
