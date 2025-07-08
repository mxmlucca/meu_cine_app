import '../../domain/entities/movie.dart';

class MovieModel extends Movie {
  const MovieModel({
    required super.id,
    required super.title,
    required super.overview,
    required super.posterPath,
    required super.voteAverage,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'],
      title: json['title'],
      overview: json['overview'],
      // A API pode retornar o caminho do poster como nulo, então tratamos isso.
      // E também precisamos do caminho completo da imagem.
      posterPath:
          json['poster_path'] != null
              ? 'https://image.tmdb.org/t/p/w500${json['poster_path']}'
              : 'https://www.themoviedb.org/assets/2/v4/glyphicons/basic/glyphicons-basic-38-picture-grey-c2ebdbb057f2a7614185931650f8cee23fa137b93812ccb132b9df511df1cfac.svg', // Uma imagem placeholder
      voteAverage: json['vote_average'].toDouble(),
    );
  }
}
