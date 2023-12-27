// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:meroio/screens/screens.dart';
import 'package:meroio/widgets/widgets.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});
  static const routeName = '/user';
  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    User? user = auth.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ваш профиль'),
      ),
      body: Center(
        child: user != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Email: ${user.email}',
                    style: TextStyle(fontSize: 18),
                  ),
                  // Add other user details if needed
                ],
              )
            : const Text('User not logged in'),
      ),
    );
  }
}
