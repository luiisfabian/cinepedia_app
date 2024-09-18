import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  // Recibimos el shell como argumento
  final StatefulNavigationShell navigationShell;
  // int getCurrentIndex(BuildContext context){
  //   final String location = GoRouterState.of(context).matchedLocation;

  //   switch (location) {
  //     case '/':
  //       return 0;
  //     case '/categories':
  //       return 1;
  //       case '/favorites':
  //       return 2;
  //     default: return 0;
  //   }
  // }

  void onItemTap(BuildContext context, int index) {
    /// Alternamos entre vistas mediante el método goBranch, este método
    /// garanriza que se restaure el último estado de navegación para la
    /// rama
    navigationShell.goBranch(
      index,
      // Soporte para ir a la ubicación inicial de la rama.
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  const CustomBottomNavigationBar({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 0,
      currentIndex: navigationShell.currentIndex,
      onTap: (value) {
        // Llamamos a la función de navegación
        onItemTap(context, value);
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_max), label: "Inicio"),
        BottomNavigationBarItem(
            icon: Icon(Icons.label_outline), label: "Categorias"),
        BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border_outlined), label: "Favoritos")
      ],
    );
  }
}
