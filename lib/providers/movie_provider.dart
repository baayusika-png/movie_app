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
      debugPrint("Error loading movies: $e");
    }

    _isLoading = false;
    notifyListeners();
  }


  final List<MovieModel> _wishlistMovies = [];

  List<MovieModel> get wishlistMovies => _wishlistMovies;

  bool isFavorite(MovieModel movie) {
    return _wishlistMovies.any((item) => item.id == movie.id);
  }

  void toggleFavorite(MovieModel movie) {
    if (isFavorite(movie)) {
      _wishlistMovies.removeWhere((item) => item.id == movie.id);
    } else {
      _wishlistMovies.add(movie);
    }

    notifyListeners();
  }


  final List<MovieModel> _myMovies = [];

  List<MovieModel> get myMovies => _myMovies;

  Future<void> addMovie(MovieModel movie) async {
    try {
      final newMovie = await MovieService.addMovie(movie);

      _myMovies.add(newMovie);
      _movies.add(newMovie);

      notifyListeners();
    } catch (e) {
      debugPrint("Error adding movie: $e");
      rethrow;
    }
  }
}
