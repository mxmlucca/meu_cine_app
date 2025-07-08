import 'package:flutter/material.dart';
import '../../domain/entities/movie_detail.dart';
import '../../domain/usecases/get_movie_detail.dart';
import '../../domain/usecases/is_movie_favorite.dart';
import '../../domain/usecases/favorite_movie.dart';
import '../../domain/usecases/unfavorite_movie.dart';

class MovieDetailProvider extends ChangeNotifier {
  final GetMovieDetail getMovieDetail;
  final IsMovieFavorite isMovieFavorite;
  final FavoriteMovie favoriteMovie;
  final UnfavoriteMovie unfavoriteMovie;

  MovieDetailProvider({
    required this.getMovieDetail,
    required this.isMovieFavorite,
    required this.favoriteMovie,
    required this.unfavoriteMovie,
  });

  bool _isLoading = false;
  MovieDetail? _movieDetail;
  String? _errorMessage;
  bool _isFavorite = false;

  bool get isLoading => _isLoading;
  MovieDetail? get movieDetail => _movieDetail;
  String? get errorMessage => _errorMessage;
  bool get isFavorite => _isFavorite;

  Future<void> fetchMovieDetail(int id) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _movieDetail = await getMovieDetail.call(id);
      _isFavorite = await isMovieFavorite.call(id);
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus() async {
    if (_movieDetail == null) return;

    try {
      if (_isFavorite) {
        await unfavoriteMovie.call(_movieDetail!.id);
      } else {
        await favoriteMovie.call(_movieDetail!.id);
      }
      _isFavorite = !_isFavorite;
      notifyListeners();
    } catch (e) {
      print("Erro ao favoritar: $e");
    }
  }
}
