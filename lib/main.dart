import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Nossos imports
import 'features/movies/data/datasources/movie_remote_datasource.dart';
import 'features/movies/data/datasources/movie_local_datasource.dart';

import 'features/movies/data/repositories/movie_repository_impl.dart';

import 'features/movies/domain/usecases/get_popular_movies.dart';
import 'features/movies/domain/usecases/get_movie_detail.dart';
import 'features/movies/domain/usecases/favorite_movie.dart';
import 'features/movies/domain/usecases/unfavorite_movie.dart';
import 'features/movies/domain/usecases/is_movie_favorite.dart';

import 'features/movies/presentation/pages/movies_page.dart';
import 'features/movies/presentation/providers/movie_provider.dart';
import 'features/movies/presentation/providers/movie_detail_provider.dart';

void main() async {
  // Garantimos que os bindings do Flutter foram inicializados antes de chamar o async
  WidgetsFlutterBinding.ensureInitialized();

  // Carregamos o SharedPreferences ANTES de rodar o app
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

  // Rodamos o app, passando a instância já pronta do SharedPreferences
  runApp(MyApp(sharedPreferences: sharedPreferences));
}

class MyApp extends StatelessWidget {
  final SharedPreferences sharedPreferences;
  const MyApp({super.key, required this.sharedPreferences});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Provider para a lista de filmes (não muda muito)
        ChangeNotifierProvider<MovieProvider>(
          create: (context) {
            final dio = Dio();
            final remoteDataSource = MovieRemoteDataSourceImpl(dio: dio);
            // Note que o localDataSource não é necessário aqui
            final repository = MovieRepositoryImpl(
              remoteDataSource: remoteDataSource,
              // Passamos a instância que já temos!
              localDataSource: MovieLocalDataSourceImpl(
                sharedPreferences: sharedPreferences,
              ),
            );
            final getPopularMovies = GetPopularMovies(repository: repository);

            final movieProvider = MovieProvider(
              getPopularMovies: getPopularMovies,
            );
            movieProvider.fetchPopularMovies();

            return movieProvider;
          },
        ), // <-- UMA VÍRGULA AQUI É ESSENCIAL!
        // Provider para a tela de detalhes (agora síncrono)
        ChangeNotifierProvider<MovieDetailProvider>(
          create: (context) {
            final dio = Dio();
            final remoteDataSource = MovieRemoteDataSourceImpl(dio: dio);
            // Usamos a mesma instância que veio do MyApp
            final localDataSource = MovieLocalDataSourceImpl(
              sharedPreferences: sharedPreferences,
            );

            final repository = MovieRepositoryImpl(
              remoteDataSource: remoteDataSource,
              localDataSource: localDataSource,
            );

            final getMovieDetail = GetMovieDetail(repository: repository);
            final favoriteMovie = FavoriteMovie(repository: repository);
            final unfavoriteMovie = UnfavoriteMovie(repository: repository);
            final isMovieFavorite = IsMovieFavorite(repository: repository);

            return MovieDetailProvider(
              getMovieDetail: getMovieDetail,
              favoriteMovie: favoriteMovie,
              unfavoriteMovie: unfavoriteMovie,
              isMovieFavorite: isMovieFavorite,
            );
          },
        ),
      ],
      child: MaterialApp(
        // ... o resto do MaterialApp continua igual
        title: 'Meu CineApp',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: const Color(0xFF151515),
          appBarTheme: const AppBarTheme(
            backgroundColor: const Color(0xFF202020),
            elevation: 0,
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: const MoviesPage(),
      ),
    );
  }
}
