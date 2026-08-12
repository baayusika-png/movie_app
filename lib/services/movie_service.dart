import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_app/model/movie_model.dart';

class MovieService {
  static const String baseUrl = 'https://fooapi.com/api/movies';

  static Future<List<MovieModel>> getMovies() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);

      final List<dynamic> data = jsonData["data"];

      return data.map((json) => MovieModel.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load movies: ${response.statusCode}");
    }
  }

  static Future<MovieModel> addMovie(MovieModel movie) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(movie.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final Map<String, dynamic> data = json.decode(response.body);

      return MovieModel.fromJson(data['data'] ?? data);
    } else {
      throw Exception('Failed to add movie: ${response.statusCode}');
    }
  }
}
