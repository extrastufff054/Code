import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_application/components/my_button.dart';
import 'package:social_media_application/components/my_textfield.dart';
import 'package:social_media_application/helper/helper_function.dart';

class LoginPage extends StatefulWidget {

  final void Function() onTap;

  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Text controllers
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  //login method
  void login() async
  {
    //show loading circle
    showDialog(
      context: context,
      builder: (context) => const Center
      (
        child: CircularProgressIndicator()
      ),
    );

    //try sign in
    try
    {
      await FirebaseAuth.instance.signInWithEmailAndPassword
      (
        email: emailController.text,
        password: passwordController.text,
      );

      //pop loading circle
      if (context.mounted) Navigator.pop(context);

      //go to home page
      Navigator.pushReplacementNamed(context, "/home");
    }

    //if login fails
    on FirebaseAuthException catch(e)
    {
      //pop loading circle
      Navigator.pop(context);

      //show error message
      displayMessageToUser(e.code, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold
    (
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center
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
              //sign in button
            MyButton
            (
              text: "Login",
              onTap: login,
            ),

            const SizedBox(height: 25),

            //don't have an account? Register here
             Row(
              mainAxisAlignment: MainAxisAlignment.center,
               children: [
                const Text("Don't have an account? ",),

                GestureDetector(
                  onTap: widget.onTap,
                  child: const Text
                  (
                    " Register Here",
                    style: TextStyle
                    (
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
    );
  }
}