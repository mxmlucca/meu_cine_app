import 'package:shared_preferences/shared_preferences.dart';

// A chave que usaremos para salvar nossa lista no "cofre" do celular.
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
    // 1. Buscamos a lista atual de favoritos.
    final favoriteIds = _getFavoriteIds();

    // 2. Adicionamos o novo ID se ele não estiver na lista.
    if (!favoriteIds.contains(id.toString())) {
      favoriteIds.add(id.toString());
    }

    // 3. Salvamos a lista atualizada de volta no shared_preferences.
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

  // Método privado para ajudar a pegar a lista de IDs.
  List<String> _getFavoriteIds() {
    // O '??' significa que se o resultado for nulo, usamos uma lista vazia.
    return sharedPreferences.getStringList(CACHED_FAVORITE_MOVIES) ?? [];
  }
}
