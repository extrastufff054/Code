import 'package:flutter/material.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold
    (
      appBar: AppBar
      (
        title: const Text
        (
          "Users",
          style : TextStyle
          (
            fontWeight: FontWeight.bold,
          )
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
      ),
      // body: Center
      // (
      //   child: Text("Users Page"),
      // ),
    );
  }
}