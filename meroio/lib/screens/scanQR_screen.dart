// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:meroio/screens/screens.dart';
import 'package:meroio/widgets/widgets.dart';

class QrScreen extends StatefulWidget {
  const QrScreen({super.key});
  static const routeName = '/qr';

  @override
  State<QrScreen> createState() => _QrScreenState();
}

class _QrScreenState extends State<QrScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavBar(index: 1),
      // bottomNavigationBar: CustomNavBar(),
      body: Center(
        child: Text('Сканирование QR'),
        // child: ElevatedButton(
        //     onPressed: () {
        //       FirebaseAuth.instance.signOut().then((value) {
        //         Navigator.push(context,
        //             MaterialPageRoute(builder: (context) => SignInScreen()));
        //       });
        //     },
        //     child: Text('Выход')),
      ),
    );
  }
}
