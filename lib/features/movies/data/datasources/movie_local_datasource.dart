import 'package:shared_preferences/shared_preferences.dart';

const String CACHED_FAVORITE_MOVIES = 'CACHED_FAVORITE_MOVIES';

abstract class MovieLocalDataSource {
  Future<void> favoriteMovie(int id);
  Future<void> unfavoriteMovie(int id);
  Future<bool> isMovieFavorite(int id);
}

class MovieLocalDataSourceImpl implements MovieLocalDataSource {
  final SharedPreferences sharedPreferences;

  MovieLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> favoriteMovie(int id) async {
    final favoriteIds = _getFavoriteIds();

    if (!favoriteIds.contains(id.toString())) {
      favoriteIds.add(id.toString());
    }

    await sharedPreferences.setStringList(CACHED_FAVORITE_MOVIES, favoriteIds);
  }

  @override
  Future<void> unfavoriteMovie(int id) async {
    final favoriteIds = _getFavoriteIds();
    favoriteIds.remove(id.toString());
    await sharedPreferences.setStringList(CACHED_FAVORITE_MOVIES, favoriteIds);
  }

  @override
  Future<bool> isMovieFavorite(int id) async {
    final favoriteIds = _getFavoriteIds();
    return favoriteIds.contains(id.toString());
  }

  List<String> _getFavoriteIds() {
    return sharedPreferences.getStringList(CACHED_FAVORITE_MOVIES) ?? [];
  }
}
