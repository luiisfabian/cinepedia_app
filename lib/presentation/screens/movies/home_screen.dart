import 'package:cinemapedia_app/presentation/providers/movies/movies_providers.dart';
import 'package:cinemapedia_app/presentation/providers/movies/movies_slideshow_provider.dart';
import 'package:cinemapedia_app/presentation/widgets/movies/movies_horizontal_listView.dart';
import 'package:cinemapedia_app/presentation/widgets/movies/movies_slideshow.dart';
import 'package:cinemapedia_app/presentation/widgets/shared/custom_appbar.dart';
import 'package:cinemapedia_app/presentation/widgets/shared/custom_bottom_navigation.dart';
import 'package:cinemapedia_app/presentation/widgets/shared/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const name = "homeScreen";

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: HomeView(),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
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
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final upcommingMovies = ref.watch(upcomingMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);
    final slideShowMovies = ref.watch(moviesSlideShowProvider);

    if (slideShowMovies.isEmpty) return const CircularProgressIndicator();

    return const  FullScreenLoader();

    return CustomScrollView(slivers: [
      const SliverAppBar(
        floating: true,
        flexibleSpace: FlexibleSpaceBar(
          title: CustomAppbar(),
        ),
      ),
      SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          return Column(
            children: [
              MoviesSlideShow(movies: slideShowMovies),
              MoviesHorizontalListview(
                movies: nowPlayingMovies,
                title: "En cines",
                subTitle: "Lunes 20",
                loadNextPage: () =>
                    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
              ),
              MoviesHorizontalListview(
                movies: popularMovies,
                title: "Populares",
                loadNextPage: () =>
                    ref.read(popularMoviesProvider.notifier).loadNextPage(),
              ),

              MoviesHorizontalListview(
                movies: upcommingMovies,
                title: "UpComing",
                loadNextPage: () =>
                    ref.read(upcomingMoviesProvider.notifier).loadNextPage(),
              ),

              MoviesHorizontalListview(
                movies: topRatedMovies,
                title: "top Rated",
                loadNextPage: () =>
                    ref.read(topRatedMoviesProvider.notifier).loadNextPage(),
              ),

              // Expanded(
              //   child: ListView.builder(
              //     itemCount: nowPlayingMovies.length,
              //     itemBuilder: (context, index) {
              //       final movie = nowPlayingMovies[index];
              //       return ListTile(
              //         title: Text(movie.title),
              //       );
              //     },
              //   ),
              // )
              const SizedBox(
                height: 10,
              )
            ],
          );
        }, childCount: 1),
      )
    ]);
  }
}
