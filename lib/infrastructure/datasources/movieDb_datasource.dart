import 'package:cinemapedia_app/config/constants/environment.dart';
import 'package:cinemapedia_app/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia_app/domain/entities/movie.dart';
import 'package:cinemapedia_app/infrastructure/mapers/movie_mapper.dart';
import 'package:cinemapedia_app/infrastructure/models/moviedb/movie_details.dart';
import 'package:cinemapedia_app/infrastructure/models/moviedb/moviedb_response.dart';
import 'package:dio/dio.dart';

class MovieDbDatasource extends MoviesDatasource {
  final dio = Dio(BaseOptions(
      baseUrl: "https://api.themoviedb.org/3",
      queryParameters: {
        'api_key': '0c6ad3c7b93bdd45bba3efd45b1b0aff',
        'lenguaje': 'es-MX'
      }));

  List<Movie> _jsonToMovies(Map<String, dynamic> json) {
    final movieDBResponse = MovieDbResponse.fromJson(json);

    final List<Movie> movies = movieDBResponse.results
        .where((moviedb) => moviedb.posterPath != 'no-poster')
        .map((moviedb) => MovieMapper.movieDBToEntity(moviedb))
        .toList();

    return movies;
  }

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get(
        'https://api.themoviedb.org/3/movie/now_playing',
        queryParameters: {'page': page});

    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getPopularMovies({int page = 1}) async {
    final response = await dio.get('https://api.themoviedb.org/3/movie/popular',
        queryParameters: {'page': page});

    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    final response = await dio.get(
        'https://api.themoviedb.org/3/movie/top_rated',
        queryParameters: {'page': page});

    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getUpcomming({int page = 1}) async {
    final response = await dio.get(
        'https://api.themoviedb.org/3/movie/upcoming',
        queryParameters: {'page': page});

    return _jsonToMovies(response.data);
  }

  @override
  Future<Movie> getMovieById(String id) async {
    final response = await dio.get('https://api.themoviedb.org/3/movie/$id');

    if (response.statusCode != 200)
      throw Exception("movie with id $id no found");

    final movieDetails = MovieDetails.fromJson(response.data);

    final Movie movie = MovieMapper.movieDetailsToEntity(movieDetails);

    return movie;
  }
}
