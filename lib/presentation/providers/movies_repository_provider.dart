import 'package:cinemapedia_app/infrastructure/datasources/movieDb_datasource.dart';
import 'package:cinemapedia_app/infrastructure/repositories/movie_repository_imple.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieRepositoryProvider = Provider((ref) {
  return MovieRespositoryImplementation(datasource: MovieDbDatasource());
});
