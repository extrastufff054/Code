import 'package:flutter/material.dart';

void displayMessageToUser(String message, BuildContext context)
{
  showDialog
  (
    context: context,
    builder: (context) => AlertDialog
    (
      title: Text(message),
    //   content: Text(message),
    //   actions:
    //   [
    //     TextButton
    //     (
    //       onPressed: () => Navigator.pop(context),
    //       child: const Text('OK')
    //     )
    //   ],
    )
  );
}