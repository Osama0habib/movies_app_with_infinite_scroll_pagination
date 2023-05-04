import 'package:flutter/material.dart';
import 'package:movies_app/movies/presentation/screens/movies_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: MainMoviesScreen(),);
  }
}
