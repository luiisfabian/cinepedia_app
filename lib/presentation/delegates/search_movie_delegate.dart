import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia_app/domain/entities/movie.dart';
import 'package:flutter/material.dart';

typedef SearchMovieCallBack = Future<List<Movie>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<Movie?> {
  @override
  String get searchFieldLabel => 'Buscar Pelicula';

  final SearchMovieCallBack searchMovies;

  SearchMovieDelegate({required this.searchMovies});

  /// todo: Sirve para construir las acciones
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      // if(query.isNotEmpty) IconButton(onPressed: () => query = '', icon: Icon(Icons.clear_rounded))
      FadeIn(
        animate: query.isNotEmpty,
        child: IconButton(
          onPressed: () => query = '',
          icon: const Icon(Icons.clear_rounded),
        ),
      )
    ];
  }

  /// todo: Sirve para construir un icono al inicio
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: Icon(Icons.arrow_back_ios_outlined),
    );
  }

  /// todo: van a aparecer los resultados al presionar enter
  @override
  Widget buildResults(BuildContext context) {
    return const Text("Hola Build results");
  }

  // todo: mientras la persona este escribiendo salen los resultados
  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: searchMovies(query),
      initialData: [],
      builder: (context, snapshot) {
      
        final movies = snapshot.data ?? [];
        return ListView.builder(
          itemBuilder: (context, index) {
            final movie = movies[index];
            return ListTile(
              title: Text(movie.title),
            );
          },
          itemCount: movies.length,
        );
      },
    );
  }
}
