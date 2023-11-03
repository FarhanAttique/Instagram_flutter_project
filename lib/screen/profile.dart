import 'package:flutter/material.dart';
import 'package:insta/resources/auth.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key});

  void signout() {
    AuthMethods().signOut(); // Call the signOut method from AuthMethods
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: signout, // Call the signout method when tapped
        child: Center(
          child: Icon(Icons.logout),
        ),
      ),
    );
  }
}
