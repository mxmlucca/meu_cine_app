import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/movie_detail_provider.dart';

class MovieDetailPage extends StatefulWidget {
  final int movieId;

  const MovieDetailPage({super.key, required this.movieId});

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  void initState() {
    super.initState();
    // Usamos o 'addPostFrameCallback' para garantir que o context está pronto
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Chamamos nosso provider para buscar os dados assim que a tela inicia
      Provider.of<MovieDetailProvider>(
        context,
        listen: false,
      ).fetchMovieDetail(widget.movieId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalhes do Filme')),
      body: Consumer<MovieDetailProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.errorMessage != null) {
            return Center(child: Text('Erro: ${provider.errorMessage}'));
          }

          if (provider.movieDetail == null) {
            return const Center(child: Text('Nenhum detalhe encontrado.'));
          }

          // UI de sucesso com os detalhes do filme
          final movie = provider.movieDetail!;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Image.network(movie.posterPath, height: 400),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Usamos Expanded para o título não estourar a tela se for muito grande
                    Expanded(
                      child: Text(
                        movie.title,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    // Nosso botão de favorito!
                    IconButton(
                      icon: Icon(
                        // O ícone muda de acordo com o estado 'isFavorite'
                        provider.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: provider.isFavorite ? Colors.red : Colors.white,
                        size: 32,
                      ),
                      onPressed: () {
                        // A ação que chama nosso método no provider
                        provider.toggleFavoriteStatus();
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Wrap(
                  // Usamos Wrap para os gêneros quebrarem a linha se necessário
                  spacing: 8.0,
                  children:
                      movie.genres
                          .map(
                            (genre) => Chip(
                              label: Text(genre.name),
                              backgroundColor: Colors.grey[800],
                            ),
                          )
                          .toList(),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 20),
                    const SizedBox(width: 4),
                    Text(
                      '${movie.voteAverage.toStringAsFixed(1)} / 10',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const Text(
                  'Sinopse',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  movie.overview,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
