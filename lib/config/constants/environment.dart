import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String movieDbKey =
      dotenv.env['THE_MOVIE_KEY'].toString() ?? "no hay api key";
}
