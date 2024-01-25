import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:social_media_application/components/my_back_button.dart';

class ProfilePage extends StatelessWidget {
 ProfilePage({super.key});

 // current logged in user
 final User? currentUser = FirebaseAuth.instance.currentUser;

 // future to fetch user details
 Future<DocumentSnapshot<Map<String, dynamic>>>? getUserDetails() async
 {
    return await FirebaseFirestore.instance
      .collection("Users")
      .doc(currentUser!.email).
      get();
 }

 Future<File?> getImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return File(pickedFile.path);
    } else {
      return null;
    }
 }

 Future<File?> downloadImage(String url) async {
    var response = await http.get(Uri.parse(url));
    var documentDirectory = await getApplicationDocumentsDirectory();
    File imgFile = File('${documentDirectory.path}/img.png');
    imgFile.writeAsBytesSync(response.bodyBytes);
    return imgFile;
 }

 Widget buildProfileImage(BuildContext context, Map<String, dynamic> user)
 {
    //profile image
    if(user != null && user['profileImage'] != null){
      return Container(
          // width: 100,
          // height: 100,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage(user['profileImage']!),
              fit: BoxFit.cover
            )
          ),
          padding: const EdgeInsets.all(25),
          child: const Icon(
            Icons.camera_alt,
            size: 64,
          )
      );
    }
    else
    {
      // Return some default widget or null if no widget should be rendered
      return Container(); // or return null;
    }
 }

 @override
 Widget build(BuildContext context) {
    return Scaffold
    (
      // appBar: AppBar
      // (
      //   title: const Text
      //   (
      //     "Profile",
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
      body : FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>
      (
        future: getUserDetails(),
        builder: (context, snapshot)
        {
          //loading
          if(snapshot.connectionState == ConnectionState.waiting)
          {
            return const Center
            (
              child: CircularProgressIndicator()
            );
          }
          //error
          else if(snapshot.hasError)
          {
            return Text("Error ${snapshot.error}");
          }

          //data recieved
          else if (snapshot.hasData)
          {
            //extract data
            Map<String, dynamic>? user = snapshot.data!.data();

            return Center
            (
              child: Column
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

                  //profile picture
                  Container
                  (
                    decoration: BoxDecoration
                    (
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(24),
                    ),
                    padding: const EdgeInsets.all(25),
                    child: const Icon
                    (
                      Icons.person,
                      size: 64,
                    ),
                  ),

                  const SizedBox(height: 25),

                  Text
                  (
                    user!['username'], style: const TextStyle
                    (
                      fontSize: 24, fontWeight: FontWeight.bold
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text
                  (
                    user['email'], style: TextStyle
                    (
                      color: Colors.grey.shade600,
                    ),
                  ),

                ],
              ),
            );
          }
          else
          {
            return const Center
            (
              child: Text("No data found"),
            );
          }
        },
      ),
    );
 }
}


