import 'dart:async';
import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia_app/config/helpers/human_format.dart';
import 'package:cinemapedia_app/domain/entities/movie.dart';
import 'package:flutter/material.dart';

typedef SearchMovieCallBack = Future<List<Movie>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<Movie?> {
  @override
  String get searchFieldLabel => 'Buscar Pelicula';

  final SearchMovieCallBack searchMovies;
  StreamController<List<Movie>> debouncedMovies = StreamController.broadcast();
  StreamController<bool> isLoadingStream = StreamController.broadcast();

  Timer? _debounceTimer;
  List<Movie> initialMovies;

  SearchMovieDelegate({required this.searchMovies, required this.initialMovies})
      : super(textInputAction: TextInputAction.done);

  void clearStreams() {
    debouncedMovies.close();
    isLoadingStream.close();
  }

  void _onQueryChange(String query) {
    isLoadingStream.add(true);
    if (_debounceTimer?.isActive ?? false) {
      _debounceTimer!.cancel();
    } else {
      _debounceTimer = Timer(
        const Duration(microseconds: 500),
        () async {
          /// buscar peliculas
          // print("Buscando Pelicula");
          // if (query.isEmpty) {
          //   bounceMovies.add([]);
          //   return;
          // }

          final movies = await searchMovies(query);
          initialMovies = movies;

          debouncedMovies.add(movies);
          isLoadingStream.add(false);
        },
      );
    }
  }

  /// todo: Sirve para construir las acciones
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      StreamBuilder(
        initialData: false,
        stream: isLoadingStream.stream,
        builder: (context, snapshot) {
          if (snapshot.data ?? false) {
            return SpinPerfect(
              duration: const Duration(seconds: 20),
              spins: 10,
              infinite: true,
              child: IconButton(
                  onPressed: () => query = '',
                  icon: const Icon(Icons.refresh_rounded)),
            );
          } else {
            return FadeIn(
              animate: query.isNotEmpty,
              child: IconButton(
                  onPressed: () => query = '', icon: const Icon(Icons.clear)),
            );
          }
        },
      ),
    ];
  }

  /// todo: Sirve para construir un icono al inicio
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        clearStreams();
        close(context, null);
      },
      icon: Icon(Icons.arrow_back_ios_outlined),
    );
  }

  /// todo: van a aparecer los resultados al presionar enter
  @override
  Widget buildResults(BuildContext context) {
    // _onQueryChange(query);

    return buildResultAndSuggestion();
  }

  // todo: mientras la persona este escribiendo salen los resultados
  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChange(query);
    return buildResultAndSuggestion();
  }

  Widget buildResultAndSuggestion() {
    return StreamBuilder(
        stream: debouncedMovies.stream,
        initialData: initialMovies,
        builder: (context, snapshot) {
          final movies = snapshot.data ?? [];
          return ListView.builder(
            itemBuilder: (context, index) {
              print("Realizanod peticion");
              final movie = movies[index];
              // return ListTile(
              //   title: Text(movie.title),
              // );
              return _MovieItem(
                  movie: movie,
                  onMovieSelected: (context, movie) {
                    clearStreams();
                    close(context, movie);
                  });
            },
            itemCount: movies.length,
          );
        });
  }
}

class _MovieItem extends StatelessWidget {
  final Movie movie;
  final Function onMovieSelected;
  const _MovieItem({required this.movie, required this.onMovieSelected});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        onMovieSelected(context, movie);
      },
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Row(
            children: [
              //image

              SizedBox(
                width: size.width * 0.2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    movie.posterPath,
                    loadingBuilder: (context, child, loadingProgress) {
                      return FadeIn(child: child);
                    },
                  ),
                ),
              ),

              SizedBox(
                width: 10,
              ),

              //description
              SizedBox(
                width: size.width * 0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(movie.title, style: textStyle.titleMedium),
                    (movie.overview.length > 100)
                        ? Text('${movie.overview.substring(0, 100)}...')
                        : Text(movie.overview),
                    Row(
                      children: [
                        Icon(Icons.star_half_rounded,
                            color: Colors.yellow.shade900),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          HumanFormats.number(movie.popularity, 1),
                          style: textStyle.bodySmall,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
