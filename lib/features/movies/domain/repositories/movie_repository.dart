import '../entities/movie.dart';
import '../entities/movie_detail.dart';

abstract class MovieRepository {
  Future<List<Movie>> getPopularMovies();
  Future<MovieDetail> getMovieDetail(int id);
  Future<void> favoriteMovie(int id);
  Future<void> unfavoriteMovie(int id);
  Future<bool> isMovieFavorite(int id);
}
