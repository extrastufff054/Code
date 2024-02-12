import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_application/auth/auth.dart';
import 'package:social_media_application/components/my_button.dart';
import 'package:social_media_application/components/my_textfield.dart';
import 'package:social_media_application/components/square_tile.dart';
import 'package:social_media_application/helper/helper_function.dart';

class RegisterPage extends StatefulWidget {

  final void Function() onTap;

  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Text controllers
  final TextEditingController usernameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPwController = TextEditingController();

  //register method
  void registerUser() async
  {
    //show loading circle
    showDialog(
      context: context,
      builder: (context) => const Center
      (
        child: CircularProgressIndicator()
      ),
    );

    //make sure passwords match
    if(passwordController.text != confirmPwController.text)
    {
      //pop loading circle
      Navigator.pop(context);

      //show error message
      displayMessageToUser("Passwords do not match", context);
      return;
    }

  //if passwords don't match
    else
    {
      //try creating the user
      try
      {
        UserCredential? usercredential = await FirebaseAuth.instance.createUserWithEmailAndPassword
        (
          email: emailController.text,
          password: passwordController.text,
        );

        //create a user document and add to firestore
        createUserDocument
        (
          usercredential,
        );

        //pop loading circle
        if(context.mounted) Navigator.pop(context);
      }
      on FirebaseAuthException catch(e)
      {
        //pop loading circle
        Navigator.pop(context);

        //show error message
        displayMessageToUser(e.code, context);
      }
    }
  }

  void displayMessage(String message)
  {
    showDialog
    (
      context: context,
      builder: (context) => AlertDialog
      (
        title: Text(message),
      )
    );
  }

  //create a user document and collect them in firestore
  Future<void> createUserDocument(UserCredential? userCredential) async
  {
    if(userCredential != null && userCredential.user != null)
    {
      await FirebaseFirestore.instance.
      collection("Users")
      .doc(userCredential.user!.email)
      .set(
        {
          'email' : userCredential.user!.email,
          'username' : usernameController.text,
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold
    (
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Center
        (
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column
            (
              mainAxisAlignment: MainAxisAlignment.center,
              children:
              [
                //logo
                Icon
                (
                  Icons.people,
                  size: 80,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
        
                const SizedBox(height: 25),
        
                //app name
        
                Text
                (
                  "A  S  S  E  N  T",
                  style: TextStyle
                  (
                    fontSize: 30,
                    letterSpacing: 5.0,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.tertiary,
                  )
                ),
        
                const SizedBox(height: 50),
        
                //username textfield
                MyTextField
                (
                  hintText: "Username",
                  obscureText: false,
                  controller: usernameController,
                ),
        
              const SizedBox(height: 10),
        
              //email textfield
                MyTextField
                (
                  hintText: "Email",
                  obscureText: false,
                  controller: emailController,
                ),
        
              const SizedBox(height: 10),
        
                //password textfield
                MyTextField
                (
                  hintText: "Password",
                  obscureText: true,
                  controller: passwordController,
                ),
        
              const SizedBox(height: 10),
        
                //confirm-password textfield
                MyTextField
                (
                  hintText: "Confirm Password",
                  obscureText: true,
                  controller: confirmPwController,
                ),
        
              const SizedBox(height: 10),
        
                //forgot password
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text
                    (
                      "Forgot Password?",
                      style: TextStyle
                      (
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ],
                ),
        
              const SizedBox(height: 25),
            //register in button
              MyButton
              (
                text: "Register",
                onTap: registerUser,
              ),
        
              const SizedBox(height: 50),
        
              //Google and Apple sign in buttons
              Row
              (
                mainAxisAlignment: MainAxisAlignment.center,
                children:
                [
                  //google sign in button
                  SquareTile
                  (
                    onTap: () => AuthPage().signInWithGoogle(),
                    imagePath: 'lib/images/google.png'
                  ),
        
                  const SizedBox(width:50.0),
        
                  //apple sign in button
                  SquareTile
                  (
                    onTap: () {},
                    imagePath: 'lib/images/apple.png'
                  )
                ],
              ),
        
              const SizedBox(height: 50),
        
              //don't have an account? Register here
               Row(
                mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                  const Text("Already have an account? ",),
        
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text
                    (
                      " Login Here",
                      style: TextStyle
                      (
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      )
                    ),
                  ),
                 ],
               ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}