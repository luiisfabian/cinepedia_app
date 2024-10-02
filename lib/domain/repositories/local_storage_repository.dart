import 'package:cinemapedia_app/domain/entities/movie.dart';

abstract class LocalStorageRepository {
  
  Future<void> toogleFavorite(Movie movie);
  Future<bool> isMoviefavorite(int movieId);
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0});
}
