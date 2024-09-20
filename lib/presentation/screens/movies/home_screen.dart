import 'package:cinemapedia_app/presentation/views/favorites_view.dart';
import 'package:cinemapedia_app/presentation/views/movies_view.dart';
import 'package:cinemapedia_app/presentation/widgets/shared/custom_bottom_navigation.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.pageIndex});

  static const name = "homeScreen";
  final int pageIndex;

  final viewRouter = const <Widget>[
    HomeView(),
    SizedBox(),
    FavoritesView(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: pageIndex,
        children: viewRouter,
      ),
      bottomNavigationBar: CustomBottomNavigationBar(currentIndex: pageIndex),
    );
  }
}
