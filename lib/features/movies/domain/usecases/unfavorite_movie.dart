import '../repositories/movie_repository.dart';

class UnfavoriteMovie {
  final MovieRepository repository;

  UnfavoriteMovie({required this.repository});

  Future<void> call(int id) async {
    await repository.unfavoriteMovie(id);
  }
}
