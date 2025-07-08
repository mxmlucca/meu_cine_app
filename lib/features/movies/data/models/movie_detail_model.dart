import '../../domain/entities/movie_detail.dart';
import 'genre_model.dart';

class MovieDetailModel extends MovieDetail {
  const MovieDetailModel({
    required super.id,
    required super.title,
    required super.overview,
    required super.posterPath,
    required super.voteAverage,
    required super.genres,
  });

  factory MovieDetailModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailModel(
      id: json['id'],
      title: json['title'],
      overview: json['overview'],
      posterPath: json['poster_path'] != null
          ? 'https://image.tmdb.org/t/p/w500${json['poster_path']}'
          : 'https://via.placeholder.com/500x750.png?text=No+Image',
      voteAverage: json['vote_average'].toDouble(),
      // Mapeamos a lista de JSONs de gênero para nossa lista de GenreModel
      genres: (json['genres'] as List)
          .map((genre) => GenreModel.fromJson(genre))
          .toList(),
    );
  }
}