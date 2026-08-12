import 'package:flutter/material.dart';
import 'package:movie_app/providers/movie_provider.dart';
import 'package:movie_app/screens/add_movies_screen.dart';
import 'package:movie_app/widgets/movie_list_card.dart';
import 'package:provider/provider.dart';

class MyMoviesScreen extends StatelessWidget {
  const MyMoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MovieProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: const Color(0xFF121212),

          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "My Collection",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 6),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${provider.myMovies.length} Movies Saved",
                      style: const TextStyle(
                        color: Color(0xFFF6C7C7),
                        fontSize: 16,
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2A2A2A),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.sort,
                              color: Colors.white, size: 18),
                          SizedBox(width: 6),
                          Text(
                            "Recently Added",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                Expanded(
                  child: provider.myMovies.isEmpty
                      ? const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.movie_creation_outlined,
                                size: 80,
                                color: Colors.white30,
                              ),
                              SizedBox(height: 20),
                              Text(
                                "No Movies Added Yet",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Tap the + button to add your first movie.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.separated(
                          itemCount: provider.myMovies.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 15),
                          itemBuilder: (context, index) {
                            final movie = provider.myMovies[index];

                            return MovieListCard(
                              title: movie.title,
                              genre: movie.genre,
                              rating: movie.imdbRating,
                              description: movie.plot,
                              image: movie.poster,
                            );
                          },
                        ),
                ),
              ],
            ),
          ),

          floatingActionButton: FloatingActionButton(
            heroTag: "addMovieButton",
            backgroundColor: Colors.red,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>  AddMovieScreen(),
                ),
              );
            },
            child: const Icon(Icons.add, color: Colors.white),
          ),
        );
      },
    );
  }
}