import '../../domain/entities/movie.dart';
import '../../domain/entities/movie_detail.dart';
import '../../domain/repositories/movie_repository.dart';
import '../datasources/movie_remote_datasource.dart';
import '../datasources/movie_local_datasource.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;
  final MovieLocalDataSource localDataSource;

  MovieRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<List<Movie>> getPopularMovies() async {
    try {
      final movieModels = await remoteDataSource.getPopularMovies();
      // Como MovieModel herda de Movie, a lista já é compatível.
      return movieModels;
    } catch (e) {
      // Em um app real, poderíamos mapear o erro para um erro de domínio.
      // Por agora, vamos apenas relançar a exceção.
      rethrow;
    }
  }

  @override
  Future<MovieDetail> getMovieDetail(int id) async {
    try {
      final movieDetailModel = await remoteDataSource.getMovieDetail(id);
      return movieDetailModel;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> favoriteMovie(int id) async {
    await localDataSource.favoriteMovie(id);
  }

  @override
  Future<bool> isMovieFavorite(int id) async {
    return await localDataSource.isMovieFavorite(id);
  }

  @override
  Future<void> unfavoriteMovie(int id) async {
    await localDataSource.unfavoriteMovie(id);
  }
}
