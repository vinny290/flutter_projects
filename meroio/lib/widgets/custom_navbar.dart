import 'package:flutter/material.dart';
import 'package:meroio/screens/add_screens.dart/first_screen.dart';
import 'package:meroio/screens/home_screen.dart';
import 'package:meroio/screens/scanQR_screen.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: index,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black.withAlpha(100),
      items: [
        BottomNavigationBarItem(
            icon: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, HomeScreen.routeName);
              },
              icon: const Icon(Icons.home_outlined, size: 34),
            ),
            label: 'Главная'),
        BottomNavigationBarItem(
            icon: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, QrScreen.routeName);
              },
              icon: const Icon(Icons.qr_code_scanner_outlined, size: 40),
            ),
            label: 'QR'),
        BottomNavigationBarItem(
            icon: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, AddScreen.routeName);
              },
              icon: const Icon(Icons.add_outlined, size: 34),
            ),
            label: 'МЕРО'),
      ],
    );
  }
}
