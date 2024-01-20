import 'package:flutter/material.dart';
import 'package:social_media_application/components/my_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold
    (
      appBar: AppBar
      (
        title: const Text(
          "Home",
          style : TextStyle
          (
            fontWeight: FontWeight.bold,
          )
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
      ),
      drawer: MyDrawer(),
    );
  }
}