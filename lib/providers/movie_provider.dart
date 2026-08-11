import 'package:flutter/material.dart';

class MovieProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _wishlistMovies = [];

  List<Map<String, dynamic>> get wishlistMovies => _wishlistMovies;

  bool isFavorite(Map<String, dynamic> movie) {
    return _wishlistMovies.any(
      (item) => item["title"] == movie["title"],
    );
  }

  void toggleFavorite(Map<String, dynamic> movie) {
    if (isFavorite(movie)) {
      _wishlistMovies.removeWhere(
        (item) => item["title"] == movie["title"],
      );
    } else {
      _wishlistMovies.add(movie);
    }

    notifyListeners();
  }
}