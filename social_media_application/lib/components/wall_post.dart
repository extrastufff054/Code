import 'package:flutter/material.dart';

class WallPost extends StatelessWidget {
  final String user;
  final String message;
  const WallPost
  (
    {
      super.key,
      required this.message,
      required this.user,
    }
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration
      (
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(8.0)
      ),
      margin: const EdgeInsets.only
      (
        top :25,
        left: 25,
        right: 25,
      ),
      padding: const EdgeInsets.all(25.0),
      child: Row
      (
        children:
        [
          Container
          (
            decoration: BoxDecoration
            (
              shape: BoxShape.circle,
              color: Theme.of(context).colorScheme.secondary,
            ),
            child: Icon
            (
              Icons.person,
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),

          Column
          (
            crossAxisAlignment: CrossAxisAlignment.start,
            children: 
            [
              Text
              (
                user,
                style: TextStyle
                (
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              const SizedBox(height: 10),
              Text(message),
            ],
          )
        ],
      ),
    );
  }
}