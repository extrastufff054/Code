import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:social_media_application/components/my_back_button.dart';
import 'package:social_media_application/components/my_list_tile.dart';
import 'package:social_media_application/helper/helper_function.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold
    (
      // appBar: AppBar
      // (
      //   title: const Text
      //   (
      //     "Users",
      //     style : TextStyle
      //     (
      //       fontWeight: FontWeight.bold,
      //     )
      //   ),
      //   centerTitle: true,
      //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      //   elevation: 0,
      // ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: StreamBuilder
      (
        stream: FirebaseFirestore.instance.collection("Users").snapshots(),
        builder: (context, snapshot)
        {
          // any errors
          if(snapshot.hasError)
          {
            displayMessageToUser("Something went wrong", context);
          }

          //show loading circle
          if(snapshot.connectionState == ConnectionState.waiting)
          {
            return const Center
            (
              child: CircularProgressIndicator()
            );
          }

          if (snapshot.data == null)
          {
            return const Center
            (
              child: Text("No users found")
            );
          }

          //get all users
          final users = snapshot.data!.docs;

          return Column
          (
            children:
            [

              //back button
                  const Padding
                  (
                    padding: EdgeInsets.only
                    (
                      top : 70.0,
                      left: 25.0
                    ),
                    child: Row
                    (
                      children:
                      [
                         MyBackButton(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),

              //list of users in the app
              Expanded
              (
                child: ListView.builder(
                  itemCount: users.length,
                  padding: const EdgeInsets.all(0),
                  itemBuilder: (context, index)
                  {
                    //get individual user
                    final user = users[index];

                    //get data from each user
                    String username = user['username'];
                    String email = user['email'];

                    return MyListTile
                    (
                      title: username,
                      subTitle: email
                    );
                  }
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}