import 'package:flutter/material.dart';

class MyListTile extends StatelessWidget {
  final String title;
  final String subTitle;
  const MyListTile
  (
    {
      super.key,
      required this.title,
      required this.subTitle
    }
  );

  @override
  Widget build(BuildContext context) {
    return Padding
      (
        padding: const EdgeInsets.only
        (
          left: 20.0,
          right: 20.0,
          top: 10.0,
          bottom: 10.0
        ),
        child: Container(
          decoration: BoxDecoration
          (
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(12.0)
          ),
          child: ListTile
          (
            title: Text(title),
            subtitle: Text
            (
              subTitle,
              style : TextStyle
              (
                color: Theme.of(context).colorScheme.secondary
              ),
            ),
          ),
        ),
      );
  }
}