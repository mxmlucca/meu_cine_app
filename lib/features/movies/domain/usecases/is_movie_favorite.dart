import '../repositories/movie_repository.dart';

class IsMovieFavorite {
  final MovieRepository repository;

  IsMovieFavorite({required this.repository});

  Future<bool> call(int id) async {
    return await repository.isMovieFavorite(id);
  }
}
