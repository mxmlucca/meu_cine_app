import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/movie_provider.dart';
import 'movie_detail_page.dart';

class MoviesPage extends StatelessWidget {
  const MoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Filmes Populares')),
      body: Consumer<MovieProvider>(
        builder: (context, provider, child) {
          // Caso 1: Estamos carregando
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // Caso 2: Ocorreu um erro
          if (provider.errorMessage != null) {
            return Center(
              child: Text(
                'Ocorreu um erro: ${provider.errorMessage}',
                style: const TextStyle(color: Colors.white),
              ),
            );
          }

          // Caso 3: Sucesso! Temos os filmes
          return GridView.builder(
            padding: const EdgeInsets.all(8.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // 2 colunas
              childAspectRatio: 0.7, // Proporção da imagem
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: provider.movies.length,
            itemBuilder: (context, index) {
              final movie = provider.movies[index];
              return GestureDetector(
                // Nosso detector de toque
                onTap: () {
                  // Ação de navegar para a nova página
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      // Passamos o ID do filme para a próxima tela
                      builder: (context) => MovieDetailPage(movieId: movie.id),
                    ),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.network(
                    movie.posterPath,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(child: CircularProgressIndicator());
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
