import 'package:flutter/material.dart';
import 'package:movie_app/providers/auth_provider.dart';
import 'package:movie_app/providers/movie_provider.dart';
import 'package:movie_app/widgets/login_required.dart';
import 'package:movie_app/widgets/movie_card.dart';
import 'package:provider/provider.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    if (!auth.isLoggedIn) {
      return const Scaffold(
        backgroundColor: Color(0xFF121212),
        body: LoginRequired(
          title: "Login to Access Wishlist",
          subtitle: "Sign in to save your favourite movies.",
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: Consumer<MovieProvider>(
        builder: (context, provider, child) {
          if (provider.wishlistMovies.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border, color: Colors.white30, size: 80),
                  SizedBox(height: 15),
                  Text(
                    "Wishlist is Empty",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Tap the heart icon to add movies.",
                    style: TextStyle(color: Colors.white54, fontSize: 16),
                  ),
                ],
              ),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: provider.wishlistMovies.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 20,
              childAspectRatio: 0.55,
            ),
            itemBuilder: (context, index) {
              return MovieCard(movie: provider.wishlistMovies[index]);
            },
          );
        },
      ),
    );
  }
}
