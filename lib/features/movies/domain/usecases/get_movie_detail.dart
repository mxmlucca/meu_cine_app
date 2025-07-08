import '../entities/movie_detail.dart';
import '../repositories/movie_repository.dart';

class GetMovieDetail {
  final MovieRepository repository;

  GetMovieDetail({required this.repository});

  Future<MovieDetail> call(int id) async {
    return await repository.getMovieDetail(id);
  }
}
