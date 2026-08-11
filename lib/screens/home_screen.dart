import 'package:flutter/material.dart';
import 'package:movie_app/widgets/movie_card.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<Map<String, dynamic>> movies = [
    {
      "title": "Neon Drift",
      "year": "2023",
      "rating": "8.4",
      "image":
          "https://images.unsplash.com/photo-1489599849927-2ee91cede3ba?w=500",
      "description":
          "In a neon-lit city, a rogue hacker uncovers a conspiracy that could change the world forever.",
    },
    {
      "title": "Void Walker",
      "year": "2024",
      "rating": "7.9",
      "image":
          "https://images.unsplash.com/photo-1517604931442-7e0c8ed2963c?w=500",
      "description":
          "A space explorer discovers a mysterious void that challenges the very fabric of reality.",
    },
    {
      "title": "Shattered Glass",
      "year": "2022",
      "rating": "8.1",
      "image":
          "https://images.unsplash.com/photo-1478720568477-152d9b164e26?w=500",
      "description":
          "A detective with a troubled past must solve a series of murders that mirror his own dark secrets.",
    },
    {
      "title": "Dark Horizon",
      "year": "2021",
      "rating": "8.7",
      "image":
          "https://images.unsplash.com/photo-1440404653325-ab127d49abc1?w=500",
      "description":
          "A mysterious force threatens to tear apart the fabric of reality.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF121212),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: "Search movies, actors...",
              hintStyle: const TextStyle(color: Colors.white70),
              prefixIcon: const Icon(Icons.search, color: Color(0xFFF6C7C7)),
              filled: true,
              fillColor: const Color(0xFF1E1E1E),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),

          const SizedBox(height: 20),

          Expanded(
            child: GridView.builder(
              itemCount: movies.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 20,
                childAspectRatio: 0.55,
              ),
              itemBuilder: (context, index) {
                return MovieCard(movie: movies[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
