import 'dart:io';

import 'package:flutter/material.dart';

class MovieListCard extends StatelessWidget {
  final String title;
  final String genre;
  final String rating;
  final String description;
  final String image;

  const MovieListCard({
    super.key,
    required this.title,
    required this.genre,
    required this.rating,
    required this.description,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          // ================= POSTER =================
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: _buildImage(),
          ),

          const SizedBox(width: 15),

          // ================= RIGHT SIDE =================
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ================= TITLE + BUTTONS =================
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(width: 5),

                    // Edit button
                    SizedBox(
                      width: 36,
                      height: 36,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                        icon: const Icon(
                          Icons.edit,
                          size: 18,
                          color: Colors.orange,
                        ),
                      ),
                    ),

                    // Delete button
                    SizedBox(
                      width: 36,
                      height: 36,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                        icon: const Icon(
                          Icons.delete_outline,
                          size: 18,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // ================= RATING + GENRE =================
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2A2A2A),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 15),
                          const SizedBox(width: 4),
                          Text(
                            rating,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: Text(
                        genre,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),

                const Spacer(),

                // ================= DESCRIPTION =================
                Text(
                  description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 15,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ================= IMAGE HANDLER =================
  Widget _buildImage() {
    // If image is a local file path
    if (image.isNotEmpty && !image.startsWith('http')) {
      return Image.file(
        File(image),
        width: 85,
        height: 130,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return _errorImage();
        },
      );
    }

    // If image is an online URL
    return Image.network(
      image,
      width: 85,
      height: 130,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return _errorImage();
      },
    );
  }

  Widget _errorImage() {
    return Container(
      width: 85,
      height: 130,
      color: const Color(0xFF2A2A2A),
      child: const Icon(Icons.movie, color: Colors.white54, size: 40),
    );
  }
}
