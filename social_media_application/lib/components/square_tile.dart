import 'package:flutter/material.dart';

class SquareTile extends StatelessWidget {
  final String imagePath;
  final Function() onTap;
  const SquareTile
  ({
    super.key,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector
    (
      onTap: onTap,
      child: Container
      (
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration
        (
          border: Border.all
          (
            color: Theme.of(context).colorScheme.secondary,
          ),
          borderRadius: BorderRadius.circular(16),
          color: Theme.of(context).colorScheme.primary,
        ),
        child: Image.asset
        (
          imagePath,
          height: 40,
        ),
      ),
    );
  }
}