import 'package:cinemapedia_app/presentation/screens/movies/home_screen.dart';
import 'package:cinemapedia_app/presentation/screens/movies/movie_screen.dart';
import 'package:cinemapedia_app/presentation/views/home_views/favorites_view.dart';
import 'package:cinemapedia_app/presentation/views/views.dart';
import 'package:go_router/go_router.dart';



final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) => HomeScreen(navigationShell: navigationShell),
      branches: <StatefulShellBranch>[
        StatefulShellBranch(
          routes: [
            GoRoute(
                builder: (context, state) {
                  return HomeView();
                },
                path: '/',
                routes: [
                  GoRoute(
                    path: 'movie/:id',
                    name: MovieScreen.name,
                    builder: (context, state) {
                      final movieId = state.pathParameters['id'] ?? 'no-id';

                      return MovieScreen(
                        movieId: movieId,
                      );
                    },
                  ),
                ]),
          ],
        ),
            // La ruta al segundo tab del navigation bar (categories)
        // StatefulShellBranch(
        //   routes: <RouteBase>[
        //     GoRoute(
        //       path: '/categories',
        //       builder: (context, state) => const CategoriesView(),
        //     )
        //   ],
        // ),
        StatefulShellBranch(routes: [
          GoRoute(
            builder: (context, state) {
              return FavoritesView();
            },
            path: '/favorites',
          ),
        ])
      ],
    )

    //todo rutas: padre - hijo
    // GoRoute(
    //   path: '/',
    //   name: HomeScreen.name,
    //   builder: (context, state) => const HomeScreen(
    //     childView: FavoritesView(),
    //   ),
    // ),
    // GoRoute(
    //   path: '/movie/:id',
    //   name: MovieScreen.name,
    //   builder: (context, state) {
    //     final movieId = state.pathParameters['id'] ?? 'no-id';

    //     return MovieScreen(
    //       movieId: movieId,
    //     );
    //   },
    // ),
  ],
);
