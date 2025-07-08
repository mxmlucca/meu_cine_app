import 'package:dio/dio.dart';
import '../models/movie_model.dart';
import '../models/movie_detail_model.dart';

// URL base e chave da API. Lembre-se de colocar a SUA chave da API aqui!
const String apiKey = '79f082b7c4cbc4357a2cac18ab8b7e37';
const String popularMoviesUrl =
    'https://api.themoviedb.org/3/movie/popular?api_key=$apiKey';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getPopularMovies();
  Future<MovieDetailModel> getMovieDetail(int id);
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final Dio dio;

  MovieRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<MovieModel>> getPopularMovies() async {
    final response = await dio.get(popularMoviesUrl);

    if (response.statusCode == 200) {
      // A API retorna uma chave 'results' que contém a lista de filmes
      final List<dynamic> results = response.data['results'];
      final List<MovieModel> movies =
          results.map((movieJson) => MovieModel.fromJson(movieJson)).toList();
      return movies;
    } else {
      // Em um app real, trataríamos o erro de forma mais robusta
      throw Exception('Failed to load popular movies');
    }
  }

  @override
  Future<MovieDetailModel> getMovieDetail(int id) async {
    final response = await dio.get(
      'https://api.themoviedb.org/3/movie/$id?api_key=$apiKey',
    );

    if (response.statusCode == 200) {
      return MovieDetailModel.fromJson(response.data);
    } else {
      throw Exception('Failed to load movie detail');
    }
  }
}
