import 'package:cinemapedia_app/config/constants/environment.dart';
import 'package:cinemapedia_app/presentation/providers/movies/movies_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const name = "homeScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: HomeView());
  }
}

class HomeView extends ConsumerStatefulWidget {
  const HomeView({
    super.key,
  });

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final movies = ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {


    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
      if(nowPlayingMovies.length == 0) return CircularProgressIndicator();
    return ListView.builder(
      itemCount: nowPlayingMovies.length,
      itemBuilder: (context, index) {
        final movie = nowPlayingMovies[index];
        return ListTile(
          title: Text(movie.title),
        );
      },
    );
  }
}
