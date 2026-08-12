import 'package:flutter/material.dart';
import 'package:movie_app/model/movie_model.dart';
import 'package:movie_app/providers/movie_provider.dart';
import 'package:provider/provider.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class AddMovieScreen extends StatefulWidget {
  const AddMovieScreen({super.key});

  @override
  State<AddMovieScreen> createState() => _AddMovieScreenState();
}

class _AddMovieScreenState extends State<AddMovieScreen> {
  File? selectedImage;

  final ImagePicker picker = ImagePicker();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController ratingController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

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

  Future<void> pickImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    }
  }

  String selectedGenre = "Action";

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
            const Text(
              "Add New Movie",
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 25),

            Center(
              child: GestureDetector(
                onTap: pickImage,
                child: Container(
                  width: 150,
                  height: 220,
                  decoration: BoxDecoration(
                    color: const Color(0xFF3A3838),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: selectedImage == null
                      ? const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_photo_alternate,
                              color: Color(0xFFF6C7C7),
                              size: 45,
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Select Poster",
                              style: TextStyle(color: Color(0xFFF6C7C7)),
                            ),
                          ],
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(selectedImage!, fit: BoxFit.cover),
                        ),
                ),
              ),
            ),

            const SizedBox(height: 25),

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

            const Text("Genre", style: TextStyle(color: Colors.white)),

            const SizedBox(height: 8),

            DropdownButtonFormField<String>(
              initialValue: selectedGenre,
              dropdownColor: const Color(0xFF1E1E1E),

              style: const TextStyle(color: Colors.white),

              decoration: inputDecoration(""),

              items: genres.map((genre) {
                return DropdownMenuItem(value: genre, child: Text(genre));
              }).toList(),

              onChanged: (value) {
                setState(() {
                  selectedGenre = value!;
                });
              },
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
                onPressed: () async {
                  if (titleController.text.isEmpty ||
                      yearController.text.isEmpty ||
                      ratingController.text.isEmpty ||
                      descriptionController.text.isEmpty ||
                      selectedImage == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please fill all fields")),
                    );
                    return;
                  }

                  MovieModel movie = MovieModel(
                    id: "",
                    title: titleController.text,
                    year: yearController.text,
                    poster: selectedImage?.path ?? "",
                    rated: "PG",
                    released: DateTime.now().toString(),
                    runtime: "120 min",
                    genre: selectedGenre,
                    director: "Unknown",
                    writer: "Unknown",
                    actors: "Unknown",
                    plot: descriptionController.text,
                    language: "English",
                    country: "Unknown",
                    awards: "None",
                    imdbRating: ratingController.text,
                    imdbId: "N/A",
                    boxOffice: "N/A",
                  );

                  try {
                    await context.read<MovieProvider>().addMovie(movie);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Movie Added Successfully")),
                    );

                    Navigator.pop(context);
                  } catch (e) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(e.toString())));
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "Save Movie",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
    super.dispose();
  }
}
