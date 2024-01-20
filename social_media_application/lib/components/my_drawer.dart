import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  //logout user
  void logout()
  {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer
    (
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column
      (
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:
        [
          Column
          (
            children:
            [
          //drawer header
              DrawerHeader(
                child: Icon
                (
                  Icons.favorite,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),

              const SizedBox(height: 25,),

          //home title
              Padding(
                padding: const EdgeInsets.only(left : 25.0),
                child: ListTile
                (
                  leading: Icon
                  (
                    Icons.home,
                    color: Colors.grey[300],
                  ),
                  title: const Text
                  (
                    "H O M E",
                    style : TextStyle
                    (
                      fontWeight: FontWeight.bold,
                    )
                  ),
                  onTap: ()
                  {
                    //pop drawer
                    Navigator.pop(context);
                  },
                ),
              ),

              const SizedBox(height: 25,),

                //profile title
              Padding(
                padding: const EdgeInsets.only(left : 25.0),
                child: ListTile
                (
                  leading: Icon
                  (
                    Icons.person,
                    color: Colors.grey[300],
                  ),
                  title: const Text
                  (
                    "P R O F I L E ",
                    style : TextStyle
                    (
                      fontWeight: FontWeight.bold,
                    )
                  ),
                  onTap: ()
                  {
                    //pop drawer
                    Navigator.pop(context);

                    //navigate to profile page
                    Navigator.pushNamed(context, '/profile_page');
                  },
                ),
              ),

              const SizedBox(height: 25,),

                //users title

              Padding
              (
                padding: const EdgeInsets.only(left : 25.0),
                child: ListTile
                (
                  leading: Icon
                  (
                    Icons.group,
                    color: Colors.grey[300],
                  ),
                  title: const Text
                  (
                    "U S E R S",
                    style : TextStyle
                    (
                      fontWeight: FontWeight.bold,
                    )
                  ),
                  onTap: ()
                  {
                    //pop drawer
                    Navigator.pop(context);

                    //navigate to profile page
                    Navigator.pushNamed(context, '/users_page');
                  },
                ),
              ),

            ],
          ),
        //Logout tile

          Padding
          (
            padding: const EdgeInsets.only(left : 25.0, bottom: 25.0),
            child: ListTile
            (
              leading: Icon
              (
                Icons.home,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              title: const Text
              (
                "L O G O U T",
                style : TextStyle
                    (
                      fontWeight: FontWeight.bold,
                    )
              ),
              onTap: ()
              {
                //pop drawer
                Navigator.pop(context);

                //logout user
                logout();
              },
            ),
          ),
        ]
      ),
    );
  }
}