import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:movie_app/widgets/movie_card.dart';
import 'package:movie_app/providers/movie_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<MovieProvider>(context, listen: false).getMovies();
    });
  }

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context);

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
            child: movieProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : movieProvider.movies.isEmpty
                ? const Center(
                    child: Text(
                      "No movies found",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  )
                : GridView.builder(
                    itemCount: movieProvider.movies.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 20,
                          childAspectRatio: 0.55,
                        ),
                    itemBuilder: (context, index) {
                      final movie = movieProvider.movies[index];

                      return MovieCard(
                        movie: {
                          "title": movie.title,
                          "year": movie.year,
                          "rating": movie.imdbRating,
                          "image": movie.poster,
                          "description": movie.plot,
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
