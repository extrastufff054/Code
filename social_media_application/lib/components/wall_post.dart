import 'package:flutter/material.dart';
import 'package:social_media_application/components/like_button.dart';

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
        borderRadius: BorderRadius.circular(12),
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
          // //profile picture
          // Container
          // (
          //   decoration: BoxDecoration
          //   (
          //     shape: BoxShape.circle,
          //     color: Theme.of(context).colorScheme.secondary,
          //   ),
          //   child: Icon
          //   (
          //     Icons.person,
          //     color: Theme.of(context).colorScheme.tertiary,
          //   ),
          // ),

          Column
          (
            children:
            [
              //like button
              LikeButton
              (
                isLiked: false,
                onTap: (){},
              ),

              //like count
            ],
          ),

          const SizedBox(width: 20),

          //message and user email
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
          ),

          const SizedBox
          (
            width: 25,
          ),

        ],
      ),
    );
  }
}