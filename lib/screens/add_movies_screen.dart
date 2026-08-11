import 'package:flutter/material.dart';

class AddMovieScreen extends StatelessWidget {
  AddMovieScreen({super.key});

  final TextEditingController posterController = TextEditingController();
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

  @override
  Widget build(BuildContext context) {
    String selectedGenre = genres.first;

    return Scaffold(
      backgroundColor: const Color(0xFF121212),

      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
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
              child: Container(
                width: 150,
                height: 220,
                decoration: BoxDecoration(
                  color: const Color(0xFF3A3838),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.image_outlined,
                      color: Color(0xFFF6C7C7),
                      size: 40,
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Poster Preview",
                      style: TextStyle(color: Color(0xFFF6C7C7)),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            const Text("Poster URL", style: TextStyle(color: Colors.white)),

            const SizedBox(height: 8),

            TextField(
              controller: posterController,
              style: const TextStyle(color: Colors.white),
              decoration: inputDecoration("https://..."),
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
                        decoration: inputDecoration("2023"),
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
                        "Rating (0-10)",
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

            StatefulBuilder(
              builder: (context, setState) {
                return DropdownButtonFormField(
                  dropdownColor: const Color(0xFF1E1E1E),
                  value: selectedGenre,
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
                );
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
                onPressed: () {},
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
}
