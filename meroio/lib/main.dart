import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:meroio/firebase_options.dart';
import 'package:meroio/screens/add_screens.dart/second_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'screens/addScreens.dart';
import 'screens/screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var auth = FirebaseAuth.instance;
  var isLogin = false;

  checkIfLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      setState(() {
        isLogin = true;
      });
    }

    auth.authStateChanges().listen((User? user) {
      if (user != null && mounted) {
        prefs.setBool('isLoggedIn', true);
        setState(() {
          isLogin = true;
        });
      } else {
        prefs.setBool('isLoggedIn', false);
      }
    });
  }

  @override
  void initState() {
    checkIfLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('ru', 'RU'),
        ],
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
          useMaterial3: true,
        ),
        initialRoute: isLogin ? HomeScreen.routeName : SignInScreen.routeName,
        routes: {
          HomeScreen.routeName: (context) => const HomeScreen(),
          QrScreen.routeName: (context) => const QrScreen(),
          UserScreen.routeName: (context) => const UserScreen(),
          SignInScreen.routeName: (context) => const SignInScreen(),
          SignUpScreen.routeName: (context) => const SignUpScreen(),
          AddScreen.routeName: (context) => const AddScreen(),
          AddSecondScreen.routeName: (context) => AddSecondScreen(),
          ForgotPasswordPage.routeName: (context) => ForgotPasswordPage(),
        });
  }
}
