import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:social_media_application/auth/login_or_register.dart';
import 'package:social_media_application/pages/home_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  //Google Sign in

  signInWithGoogle() async
  {
    //being interactive sign in process
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    // obtain auth details from request
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    // create a new credential for user
    final credential = GoogleAuthProvider.credential
    (
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    //finally, let's sign in
    return FirebaseAuth.instance.signInWithCredential(credential);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold
    (
      body : StreamBuilder
      (
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot)
        {
          //user is logged in
          if(snapshot.hasData)
          {
            return HomePage();
          }

          //user is not logged in
          else
          {
            return const LoginOrRegister();
          }
        },
      ),
    );
  }
}