import 'package:flutter/material.dart';
import '../../domain/entities/movie_detail.dart';
import '../../domain/usecases/get_movie_detail.dart';
// Nossos novos imports
import '../../domain/usecases/is_movie_favorite.dart';
import '../../domain/usecases/favorite_movie.dart';
import '../../domain/usecases/unfavorite_movie.dart';

class MovieDetailProvider extends ChangeNotifier {
  // UseCases
  final GetMovieDetail getMovieDetail;
  final IsMovieFavorite isMovieFavorite; // NOVO
  final FavoriteMovie favoriteMovie; // NOVO
  final UnfavoriteMovie unfavoriteMovie; // NOVO

  MovieDetailProvider({
    required this.getMovieDetail,
    required this.isMovieFavorite, // NOVO
    required this.favoriteMovie, // NOVO
    required this.unfavoriteMovie, // NOVO
  });

  // Estados
  bool _isLoading = false;
  MovieDetail? _movieDetail;
  String? _errorMessage;
  bool _isFavorite = false; // NOVO estado para o botão

  // Getters
  bool get isLoading => _isLoading;
  MovieDetail? get movieDetail => _movieDetail;
  String? get errorMessage => _errorMessage;
  bool get isFavorite => _isFavorite; // NOVO getter

  // Ações
  Future<void> fetchMovieDetail(int id) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _movieDetail = await getMovieDetail.call(id);
      // Assim que pegamos os detalhes, checamos se ele já é um favorito
      _isFavorite = await isMovieFavorite.call(id); // NOVO
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  // NOVA ação para o botão
  Future<void> toggleFavoriteStatus() async {
    if (_movieDetail == null) return;

    try {
      if (_isFavorite) {
        await unfavoriteMovie.call(_movieDetail!.id);
      } else {
        await favoriteMovie.call(_movieDetail!.id);
      }
      // Invertemos o estado localmente e notificamos a UI
      _isFavorite = !_isFavorite;
      notifyListeners();
    } catch (e) {
      // Em um app real, mostraríamos um erro ao usuário
      print("Erro ao favoritar: $e");
    }
  }
}
