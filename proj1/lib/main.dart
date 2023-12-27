import 'dart:convert';
import 'dart:js';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';

import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'package:shoppers/firebase_options.dart';
import 'package:shoppers/screens/checkout.dart';
import 'package:shoppers/screens/home.dart';
import 'package:shoppers/screens/login.dart';
import 'package:shoppers/screens/profile.dart';
import 'package:shoppers/utils/application_state.dart';
import 'package:shoppers/utils/custom_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //Strepie setup
  try {
    print("Loading JSON file...");
    final String response =
        await rootBundle.loadString("assets/config/stripe.json");
    print("Decoding JSON...");
    final data = await json.decode(response);
    print("Data: $data");
    print("Before setting Stripe publishableKey: ${Stripe.publishableKey}");
    Stripe.publishableKey = data["publishableKey"];
    print("After setting Stripe publishableKey: ${Stripe.publishableKey}");
  } catch (e) {
    print("Error loading or decoding JSON: $e");
  }
  ;

  runApp(
    ChangeNotifierProvider(
      create: (context) => ApplicationState(),
      builder: (context, _) => Consumer<ApplicationState>(
        builder: (context, applicationState, _) {
          Widget child;
          switch (applicationState.loginState) {
            case ApplicationLoginState.loggedOut:
              child = LoginScreen();
              break;
            case ApplicationLoginState.loggedIn:
              child = MyApp();
              break;
            default:
              child = LoginScreen();
          }

          return MaterialApp(
              theme: CustomTheme.getTheme(),
              home: child); // Add this line to return the Widget.
        },
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('CHEF-BOX'),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35), topRight: Radius.circular(35)),
            boxShadow: CustomTheme.cardShadow,
          ),
          child: const TabBar(
              padding: EdgeInsets.symmetric(vertical: 10),
              indicatorColor: Colors.transparent,
              tabs: [
                Tab(icon: Icon(Icons.home)),
                Tab(icon: Icon(Icons.person)),
                Tab(icon: Icon(Icons.shopping_cart)),
              ]),
        ),
        body: TabBarView(
          children: const [
            HomeScreen(),
            ProfileScreen(),
            CheckOutScreen(),
          ],
        ),
      ),
    );
  }
}
