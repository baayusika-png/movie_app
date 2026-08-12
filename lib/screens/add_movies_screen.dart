import 'package:flutter/material.dart';
import 'package:movie_app/model/movie_model.dart';
import 'package:movie_app/providers/movie_provider.dart';
import 'package:provider/provider.dart';

class AddMovieScreen extends StatefulWidget {
  final MovieModel? movieToEdit;

  const AddMovieScreen({super.key, this.movieToEdit});

  @override
  State<AddMovieScreen> createState() => _AddMovieScreenState();
}

class _AddMovieScreenState extends State<AddMovieScreen> {
  late final TextEditingController titleController;
  late final TextEditingController yearController;
  late final TextEditingController ratingController;
  late final TextEditingController descriptionController;
  late final TextEditingController imageUrlController;

  bool isSaving = false;

  bool get isEditing => widget.movieToEdit != null;

  final List<String> genres = [
    "Action",
    "Adventure",
    "Comedy",
    "Drama",
    "Horror",
    "Romance",
    "Sci-Fi",
    "Thriller",
  ];

  final List<String> ratedOptions = ["G", "PG", "PG-13", "R", "Not Rated"];

  late String selectedGenre;
  late String selectedRated;

  @override
  void initState() {
    super.initState();

    final movie = widget.movieToEdit;

    titleController = TextEditingController(text: movie?.title ?? "");
    yearController = TextEditingController(text: movie?.year ?? "");
    ratingController = TextEditingController(text: movie?.rating ?? "");
    descriptionController = TextEditingController(
      text: movie?.description ?? "",
    );
    imageUrlController = TextEditingController(text: movie?.image ?? "");

    selectedGenre = (movie != null && genres.contains(movie.genre))
        ? movie.genre
        : genres.first;
    selectedRated = (movie != null && ratedOptions.contains(movie.rated))
        ? movie.rated
        : ratedOptions.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),

      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Color(0xFFF6C7C7)),
        ),
        title: const Text(
          "My Movies",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text(
              isEditing ? "Edit Movie" : "Add New Movie",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 25),

            Center(
              child: Container(
                width: 150,
                height: 220,
                decoration: BoxDecoration(
                  color: const Color(0xFF3A3838),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: imageUrlController.text.isEmpty
                    ? const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.image_outlined,
                            color: Color(0xFFF6C7C7),
                            size: 45,
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Poster Preview",
                            style: TextStyle(color: Color(0xFFF6C7C7)),
                          ),
                        ],
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          imageUrlController.text,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(
                              child: Icon(
                                Icons.broken_image_outlined,
                                color: Colors.white38,
                                size: 40,
                              ),
                            );
                          },
                        ),
                      ),
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              "Poster Image URL",
              style: TextStyle(color: Colors.white),
            ),

            const SizedBox(height: 8),

            TextField(
              controller: imageUrlController,
              style: const TextStyle(color: Colors.white),
              decoration: inputDecoration("https://example.com/poster.jpg"),
              onChanged: (_) {
                setState(() {});
              },
            ),

            const SizedBox(height: 18),

            const Text("Movie Title", style: TextStyle(color: Colors.white)),

            const SizedBox(height: 8),

            TextField(
              controller: titleController,
              style: const TextStyle(color: Colors.white),
              decoration: inputDecoration("e.g. Inception"),
            ),

            const SizedBox(height: 18),

            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      const Text("Year", style: TextStyle(color: Colors.white)),

                      const SizedBox(height: 8),

                      TextField(
                        controller: yearController,
                        style: const TextStyle(color: Colors.white),
                        decoration: inputDecoration("2025"),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 15),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      const Text(
                        "Rating",
                        style: TextStyle(color: Colors.white),
                      ),

                      const SizedBox(height: 8),

                      TextField(
                        controller: ratingController,
                        style: const TextStyle(color: Colors.white),
                        decoration: inputDecoration("8.5"),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Genre",
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        initialValue: selectedGenre,
                        dropdownColor: const Color(0xFF1E1E1E),
                        style: const TextStyle(color: Colors.white),
                        decoration: inputDecoration(""),
                        items: genres.map((genre) {
                          return DropdownMenuItem(
                            value: genre,
                            child: Text(genre),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedGenre = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 15),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Rated",
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        initialValue: selectedRated,
                        dropdownColor: const Color(0xFF1E1E1E),
                        style: const TextStyle(color: Colors.white),
                        decoration: inputDecoration(""),
                        items: ratedOptions.map((r) {
                          return DropdownMenuItem(value: r, child: Text(r));
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedRated = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            const Text("Description", style: TextStyle(color: Colors.white)),

            const SizedBox(height: 8),

            TextField(
              controller: descriptionController,
              maxLines: 5,
              style: const TextStyle(color: Colors.white),
              decoration: inputDecoration("Brief synopsis..."),
            ),

            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: isSaving ? null : _handleSave,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: isSaving
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2.5,
                        ),
                      )
                    : Text(
                        isEditing ? "Update Movie" : "Save Movie",
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleSave() async {
    if (titleController.text.isEmpty ||
        yearController.text.isEmpty ||
        ratingController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        imageUrlController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please fill all fields")));
      return;
    }

    setState(() => isSaving = true);

    try {
      if (isEditing) {
        final id = widget.movieToEdit!.id;

        await context.read<MovieProvider>().updateMovie(id, {
          "title": titleController.text,
          "year": yearController.text,
          "rated": selectedRated,
          "genre": selectedGenre,
          "description": descriptionController.text,
          "image": imageUrlController.text,
          "rating": ratingController.text,
        });

        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Movie Updated Successfully")),
        );
      } else {
        final movie = MovieModel(
          id: "",
          title: titleController.text,
          year: yearController.text,
          rated: selectedRated,
          genre: selectedGenre,
          description: descriptionController.text,
          image: imageUrlController.text,
          rating: ratingController.text,
        );

        await context.read<MovieProvider>().addMovie(movie);

        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Movie Added Successfully")),
        );
      }

      if (!mounted) return;
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      if (mounted) {
        setState(() => isSaving = false);
      }
    }
  }

  InputDecoration inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.white38),
      filled: true,
      fillColor: const Color(0xFF1E1E1E),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    yearController.dispose();
    ratingController.dispose();
    descriptionController.dispose();
    imageUrlController.dispose();
    super.dispose();
  }
}
