import 'package:cinemapedia_app/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia_app/domain/entities/actor.dart';
import 'package:cinemapedia_app/infrastructure/mapers/actor_mapper.dart';
import 'package:cinemapedia_app/infrastructure/models/moviedb/credits_response.dart';
import 'package:dio/dio.dart';

class ActorMoviedbDatasource extends ActorsDatasource {
  final dio = Dio(BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': '0c6ad3c7b93bdd45bba3efd45b1b0aff',
        'lenguaje': 'es-MX'
      }));

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {
    final response =
        await dio.get('https://api.themoviedb.org/3/movie/${movieId}/credits');

    final castResponse = CreditsResponse.fromJson(response.data);


    /// croe la lista de actores
    List<Actor> actors =
        castResponse.cast.map((cast) => ActorMapper.castToEntity(cast)).toList();

    return actors;
  }
}
