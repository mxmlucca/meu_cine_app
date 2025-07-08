import 'package:flutter/material.dart';
import '../../domain/entities/movie.dart';
import '../../domain/usecases/get_popular_movies.dart';

class MovieProvider extends ChangeNotifier {
  final GetPopularMovies getPopularMovies;

  MovieProvider({required this.getPopularMovies});

  bool _isLoading = false;
  List<Movie> _movies = [];
  String? _errorMessage;

  bool get isLoading => _isLoading;
  List<Movie> get movies => _movies;
  String? get errorMessage => _errorMessage;

  Future<void> fetchPopularMovies() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _movies = await getPopularMovies.call();
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}
