import 'package:cinemapedia_app/domain/datasources/local_storage_datasource.dart';
import 'package:cinemapedia_app/domain/entities/movie.dart';

class IsarDatasource extends LocalStorageDataSource {
  @override
  Future<bool> isMoviefavorite(int movieId) {
    // TODO: implement isMoviefavorite
    throw UnimplementedError();
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, Offset = 0}) {
    // TODO: implement loadMovies
    throw UnimplementedError();
  }

  @override
  Future<void> toogleFavorite(Movie movie) {
    // TODO: implement toogleFavorite
    throw UnimplementedError();
  }

}