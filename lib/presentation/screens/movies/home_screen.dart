import 'package:cinemapedia_app/presentation/widgets/shared/custom_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.navigationShell});

  // En lugar de recibir el Widget childView, reemplazamos por el shell de navegación,
  // el cual, es un contenedor de las ramas que definimos en el router.
  final StatefulNavigationShell navigationShell;
  static const name = "homeScreen";

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: navigationShell
      ),
      bottomNavigationBar: CustomBottomNavigationBar(navigationShell: navigationShell,),
    );
  }
}
