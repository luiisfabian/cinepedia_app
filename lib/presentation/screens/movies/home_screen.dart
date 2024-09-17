import 'package:cinemapedia_app/presentation/widgets/shared/custom_bottom_navigation.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.childView});

  final Widget childView;
  static const name = "homeScreen";

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: childView
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
