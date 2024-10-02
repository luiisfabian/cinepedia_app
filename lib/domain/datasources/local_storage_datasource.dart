import 'package:cinemapedia_app/domain/entities/movie.dart';

abstract class LocalStorageDataSource {
  
  Future<void> toogleFavorite(Movie movie);
  Future<bool> isMoviefavorite(int movieId);
  Future<List<Movie>> loadMovies({int limit = 10, Offset = 0});
  
}
