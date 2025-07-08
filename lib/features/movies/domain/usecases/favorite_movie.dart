import '../repositories/movie_repository.dart';

class FavoriteMovie {
  final MovieRepository repository;

  FavoriteMovie({required this.repository});

  Future<void> call(int id) async {
    await repository.favoriteMovie(id);
  }
}
