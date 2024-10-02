import 'package:cinemapedia_app/domain/datasources/local_storage_datasource.dart';
import 'package:cinemapedia_app/domain/entities/movie.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarDatasource extends LocalStorageDataSource {
  late Future<Isar> db;

  IsarDatasource() {
    db = openDB();
  }

  Future<Isar> openDB() async{

    final dir = await getApplicationCacheDirectory();

    if (Isar.instanceNames.isEmpty) {
      return await Isar.open([MovieSchema],inspector:  true, directory: dir.path);
    }

    return Future.value(Isar.getInstance());
  }

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
