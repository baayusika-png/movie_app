import 'package:flutter/material.dart';
import 'package:movie_app/model/movie_model.dart';
import '../services/movie_service.dart';

class MovieProvider extends ChangeNotifier {
  List<MovieModel> _movies = [];

  List<MovieModel> get movies => _movies;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> getMovies() async {
    _isLoading = true;
    notifyListeners();

    try {
      _movies = await MovieService.getMovies();
    } catch (e) {
      debugPrint('Error loading movies: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  final List<Map<String, dynamic>> _wishlistMovies = [];

  List<Map<String, dynamic>> get wishlistMovies => _wishlistMovies;

  bool isFavorite(Map<String, dynamic> movie) {
    return _wishlistMovies.any((item) => item["title"] == movie["title"]);
  }

  void toggleFavorite(Map<String, dynamic> movie) {
    if (isFavorite(movie)) {
      _wishlistMovies.removeWhere((item) => item["title"] == movie["title"]);
    } else {
      _wishlistMovies.add(movie);
    }

    notifyListeners();
  }
}
