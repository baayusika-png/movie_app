import 'package:flutter/material.dart';
import 'package:movie_app/model/movie_model.dart';
import 'package:movie_app/providers/auth_provider.dart';
import 'package:movie_app/providers/movie_provider.dart';
import 'package:movie_app/screens/add_movies_screen.dart';
import 'package:movie_app/widgets/login_required.dart';
import 'package:movie_app/widgets/movie_list_card.dart';
import 'package:provider/provider.dart';

class MyMoviesScreen extends StatefulWidget {
  const MyMoviesScreen({super.key});

  @override
  State<MyMoviesScreen> createState() => _MyMoviesScreenState();
}

class _MyMoviesScreenState extends State<MyMoviesScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MovieProvider>().getMovies();
    });
  }

  void _openEditScreen(MovieModel movie) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => AddMovieScreen(movieToEdit: movie)),
    );
  }

  Future<void> _confirmDelete(MovieModel movie) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1E1E1E),
          title: const Text(
            "Delete Movie",
            style: TextStyle(color: Colors.white),
          ),
          content: Text(
            'Are you sure you want to delete "${movie.title}"?',
            style: const TextStyle(color: Colors.white70),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: const Text("No", style: TextStyle(color: Colors.white70)),
            ),
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: const Text("Yes", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );

    if (confirmed != true) return;
    if (!mounted) return;

    try {
      await context.read<MovieProvider>().deleteMovie(movie.id);

      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Movie Deleted")));
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    if (!auth.isLoggedIn) {
      return const Scaffold(
        backgroundColor: Color(0xFF121212),
        body: LoginRequired(
          title: "Login to Access My Movies",
          subtitle: "Sign in to add, edit and manage your movie collection.",
        ),
      );
    }

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
                      "${provider.movies.length} Movies Saved",
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
                          Icon(Icons.sort, color: Colors.white, size: 18),
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
                  child: provider.isLoading
                      ? const Center(
                          child: CircularProgressIndicator(color: Colors.red),
                        )
                      : provider.movies.isEmpty
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
                      : RefreshIndicator(
                          onRefresh: () => provider.getMovies(),
                          child: ListView.separated(
                            itemCount: provider.movies.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 15),
                            itemBuilder: (context, index) {
                              final movie = provider.movies[index];

                              return MovieListCard(
                                title: movie.title,
                                genre: movie.genre,
                                rating: movie.rating,
                                description: movie.description,
                                image: movie.image,
                                onEdit: () => _openEditScreen(movie),
                                onDelete: () => _confirmDelete(movie),
                              );
                            },
                          ),
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
                MaterialPageRoute(builder: (_) => const AddMovieScreen()),
              );
            },
            child: const Icon(Icons.add, color: Colors.white),
          ),
        );
      },
    );
  }
}
