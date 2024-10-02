import 'package:cinemapedia_app/domain/datasources/local_storage_datasource.dart';
import 'package:cinemapedia_app/domain/entities/movie.dart';
import 'package:cinemapedia_app/domain/repositories/local_storage_repository.dart';

class LocalStorageRepositoryImple extends LocalStorageRepository {
  final LocalStorageDataSource dataSource;

  LocalStorageRepositoryImple({required this.dataSource});

  @override
  Future<bool> isMoviefavorite(int movieId) {
    return dataSource.isMoviefavorite(movieId);
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0}) {
    return dataSource.loadMovies(limit: limit, offset: offset);
  }

  @override
  Future<void> toogleFavorite(Movie movie) {
    return dataSource.toogleFavorite(movie);
  }
}
