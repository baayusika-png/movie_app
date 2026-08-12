import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_app/model/movie_model.dart';

class MovieService {
  static const String baseUrl =
      'https://6a7c44b9a008c10e4cbf2fbb.mockapi.io/api/v1/movies/movies';
      
  static Future<List<MovieModel>> getMovies() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
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
      return MovieModel.fromJson(data);
    } else {
      throw Exception('Failed to add movie: ${response.statusCode}');
    }
  }

  static Future<MovieModel> updateMovie(
    String id,
    Map<String, dynamic> updates,
  ) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(updates),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return MovieModel.fromJson(data);
    } else {
      throw Exception('Failed to update movie: ${response.statusCode}');
    }
  }

  static Future<void> deleteMovie(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Failed to delete movie: ${response.statusCode}');
    }
  }
}