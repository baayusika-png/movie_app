import 'package:flutter/material.dart';
import 'package:movie_app/screens/add_movies_screen.dart';
import 'package:movie_app/widgets/movie_list_card.dart';

class MyMoviesScreen extends StatelessWidget {
  const MyMoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
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
                const Text(
                  "24 Movies Saved",
                  style: TextStyle(color: Color(0xFFF6C7C7), fontSize: 16),
                ),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xFF2A2A2A),
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
              child: ListView.separated(
                itemCount: 3,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 15),

                itemBuilder: (context, index) {
                  if (index == 0) {
                    return const MovieListCard(
                      title: "Neon Shadows",
                      genre: "Sci-Fi",
                      rating: "8.4",
                      description:
                          "A detective navigates a futuristic metropolis to uncover hidden secrets.",
                      image: "https://picsum.photos/200/301",
                    );
                  }

                  if (index == 1) {
                    return const MovieListCard(
                      title: "The Cabin",
                      genre: "Thriller",
                      rating: "7.9",
                      description:
                          "A weekend getaway turns into a psychological battle when strange events unfold.",
                      image: "https://picsum.photos/200/302",
                    );
                  }

                  return const MovieListCard(
                    title: "Velocity",
                    genre: "Action",
                    rating: "9.1",
                    description:
                        "High-stakes heist across international borders. Non-stop action scenes.",
                    image: "https://picsum.photos/200/303",
                  );
                },
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddMovieScreen()),
          );
        },
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),
    );
  }
}
