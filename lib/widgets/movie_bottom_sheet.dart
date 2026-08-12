import 'dart:io';

import 'package:flutter/material.dart';
import 'package:movie_app/model/movie_model.dart';
import 'package:movie_app/providers/movie_provider.dart';
import 'package:provider/provider.dart';

class MovieBottomSheet extends StatelessWidget {
  final MovieModel movie;
  final ScrollController scrollController;

  const MovieBottomSheet({
    super.key,
    required this.movie,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF121212),
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),

            // Drag handle
            Center(
              child: Container(
                width: 60,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),

            const SizedBox(height: 18),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Hero(
                tag: movie.id,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: _buildMovieImage(),
                ),
              ),
            ),

            const SizedBox(height: 18),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Wrap(
                spacing: 8,
                children: [_chip(movie.genre), _ratingChip(movie.imdbRating)],
              ),
            ),

            const SizedBox(height: 18),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                movie.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Text(
                    movie.year,
                    style: const TextStyle(
                      color: Color(0xFFF6C7C7),
                      fontSize: 17,
                    ),
                  ),
                  const Text("  •  ", style: TextStyle(color: Colors.white38)),
                  Text(
                    movie.runtime,
                    style: const TextStyle(color: Colors.white70, fontSize: 17),
                  ),
                  const Text("  •  ", style: TextStyle(color: Colors.white38)),
                  Text(
                    movie.rated,
                    style: const TextStyle(color: Colors.white70, fontSize: 17),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Divider(color: Colors.white24),
            ),

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                movie.plot,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 17,
                  height: 1.7,
                ),
              ),
            ),

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Director: ${movie.director}",
                style: const TextStyle(color: Colors.white70, fontSize: 16),
              ),
            ),

            const SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Actors: ${movie.actors}",
                style: const TextStyle(color: Colors.white70, fontSize: 16),
              ),
            ),

            const SizedBox(height: 30),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 56,
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE50914),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        icon: const Icon(Icons.play_arrow, color: Colors.white),
                        label: const Text(
                          "Watch Trailer",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 15),

                  // Favorite
                  Consumer<MovieProvider>(
                    builder: (context, provider, child) {
                      final isFav = provider.isFavorite(movie);

                      return Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E1E1E),
                          border: Border.all(color: Colors.white24),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          onPressed: () {
                            provider.toggleFavorite(movie);
                          },
                          icon: Icon(
                            isFav ? Icons.favorite : Icons.favorite_border,
                            color: isFav ? Colors.red : Colors.white,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 35),
          ],
        ),
      ),
    );
  }

  Widget _buildMovieImage() {
    // API image URL
    if (movie.poster.startsWith('http')) {
      return Image.network(
        movie.poster,
        height: 430,
        width: double.infinity,
        fit: BoxFit.cover,

        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }

          return const SizedBox(
            height: 430,
            child: Center(child: CircularProgressIndicator(color: Colors.red)),
          );
        },

        errorBuilder: (context, error, stackTrace) {
          return _errorImage();
        },
      );
    }

    return Image.file(
      File(movie.poster),
      height: 430,
      width: double.infinity,
      fit: BoxFit.cover,

      errorBuilder: (context, error, stackTrace) {
        return _errorImage();
      },
    );
  }

  Widget _errorImage() {
    return Container(
      height: 430,
      width: double.infinity,
      color: Colors.black26,
      child: const Center(
        child: Icon(Icons.movie, color: Colors.white54, size: 70),
      ),
    );
  }

  Widget _chip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xFFF6C7C7),
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _ratingChip(String rating) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.star, color: Colors.amber, size: 16),
          const SizedBox(width: 5),
          Text(
            rating,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
