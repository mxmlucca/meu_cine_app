import 'genre.dart';
import 'movie.dart';

class MovieDetail extends Movie {
  final List<Genre> genres;
  // Poderíamos adicionar outros campos como 'runtime', 'status', etc.
  // Por agora, os gêneros são um ótimo exemplo.

  const MovieDetail({
    required super.id,
    required super.title,
    required super.overview,
    required super.posterPath,
    required super.voteAverage,
    required this.genres,
  });

  @override
  List<Object?> get props => [super.props, genres];
}
