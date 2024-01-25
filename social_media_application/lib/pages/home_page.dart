import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_media_application/components/my_drawer.dart';
import 'package:social_media_application/components/my_list_tile.dart';
import 'package:social_media_application/components/my_post_button.dart';
import 'package:social_media_application/components/my_textfield.dart';
import 'package:social_media_application/database/firestore.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  //firestore access
  final FirestoreDatabase database = FirestoreDatabase();

  //text controller
  final TextEditingController newPostcontroller = TextEditingController();

  //post message
  void postMessage()
  {
    // only post message if there is something in the textfield
    if (newPostcontroller.text.isNotEmpty)
    {
      String message = newPostcontroller.text;
      database.addPost(message);
    }

    //clear controller
    newPostcontroller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold
    (
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar
      (
        title: const Text
        (
          "W A L L",
          style : TextStyle
          (
            fontWeight: FontWeight.bold,
          )
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,

        centerTitle: true,
        elevation: 0,
      ),
      drawer: const MyDrawer(),
      body: Column
      (
        children:
        [
          // TEXTFIELD BOX FOR USER TO TYPE
          Padding(
            padding: const EdgeInsets.all
            (
              25.0
            ),
            child: Row(
              children: [
                //textfield
                Expanded(
                  child: MyTextField
                  (
                    hintText: "Say something...",
                    obscureText: false,
                    controller: newPostcontroller
                  ),
                ),

                //post button
                PostButton
                (
                  onTap : postMessage
                )
              ],
            ),
          ),

          //POSTS
          StreamBuilder
          (
            stream: database.getPostsStream(),
            builder: (context,snapshot)
            {
              //show loading circle
              if (snapshot.connectionState == ConnectionState.waiting)
              {
                return const Center
                (
                  child: CircularProgressIndicator(),
                );
              }

              //get all posts
              final posts = snapshot.data!.docs;

              //no data
              if(snapshot.data!.docs.isEmpty)
              {
                return const Center
                (
                  child: Padding(
                    padding: EdgeInsets.all(25.0),
                    child: Text
                    (
                      "No posts yet....Post something!",
                      style: TextStyle
                      (
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                );
              }

              //return as a list
              return Expanded
              (
                child: ListView.builder
                (
                  itemCount: posts.length,
                  itemBuilder: ((context, index)
                  {
                    //get each individual post
                    final post = posts[index];

                    //get data from each post
                    String message = post["PostMessage"];
                    String userEmail = post["UserEmail"];
                    Timestamp timestamp = post["TimeStamp"];

                    //return as a list tile
                    return MyListTile
                    (
                      title: message,
                      subTitle: userEmail
                    );
                  })
                )
              );
            } ,
          ),

        ],
      ),
    );
  }
}