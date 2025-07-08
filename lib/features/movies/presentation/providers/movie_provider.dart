import 'package:flutter/material.dart';
import '../../domain/entities/movie.dart';
import '../../domain/usecases/get_popular_movies.dart';

class MovieProvider extends ChangeNotifier {
  final GetPopularMovies getPopularMovies;

  MovieProvider({required this.getPopularMovies});

  // Nossos estados
  bool _isLoading = false;
  List<Movie> _movies = [];
  String? _errorMessage;

  // Getters para a UI acessar os estados de forma segura
  bool get isLoading => _isLoading;
  List<Movie> get movies => _movies;
  String? get errorMessage => _errorMessage;

  // Ação que a UI vai chamar
  Future<void> fetchPopularMovies() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners(); // Avisa a UI que estamos carregando

    try {
      _movies = await getPopularMovies.call();
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners(); // Avisa a UI que terminamos (com sucesso ou erro)
  }
}
