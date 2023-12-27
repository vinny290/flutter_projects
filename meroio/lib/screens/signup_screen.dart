import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meroio/widgets/_logoWidget.dart';

import 'screens.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);
  static const routeName = '/signUp';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _userNameTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _passwordCheckTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _phoneTextController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _emailTextController.dispose();
    _userNameTextController.dispose();
    _passwordTextController.dispose();
    _phoneTextController.dispose();
    super.dispose();
  }

  Future signUp() async {
    if (passwordConfirmed()) {
      showDialog(
          context: context,
          builder: (context) {
            return Center(
              child: CircularProgressIndicator(),
            );
          });
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailTextController.text.trim(),
        password: _passwordTextController.text.trim(),
      );

      //details
      userRegDetails(
        _userNameTextController.text.trim(),
        _emailTextController.text.trim(),
        _phoneTextController.text.trim(),
        _passwordTextController.text.trim(),
      );
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    }
  }

  Future userRegDetails(
      String userName, String email, String phone, String password) async {
    DocumentReference<Map<String, dynamic>> userCollection = FirebaseFirestore
        .instance
        .collection(
            email) // Замените 'users' на ваш путь к коллекции пользователей
        .doc('Профиль');

    // CollectionReference userCollection =
    //     FirebaseFirestore.instance.collection(email).doc('Информация');

    // Добавляем документ с регистрационными данными
    await userCollection.set({
      'fullName': userName,
      'phone': phone,
      'email': email,
      'password': password,
    });

    // Добавляем документ с данными мероприятия
    // await userCollection.doc('events').collection('registeredEvents').add({
    //   'eventName': eventName,
    //   'place': 'Место мероприятия',
    //   'description': 'Описание мероприятия',
    // });

    // await FirebaseFirestore.instance.collection('mero').add({
    //   'ФИО': userName,
    //   'Email': email,
    //   'Телефон': phone,
    // });
  }

  bool passwordConfirmed() {
    if (_passwordTextController.text.trim() ==
        _passwordCheckTextController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Регистрация',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.2, 20, 0),
            child: Column(
              children: [
                SizedBox(height: 20),
                textFieldWidget('ФИО', Icons.person_outline, false,
                    _userNameTextController),
                SizedBox(height: 20),
                textFieldWidget(
                    'Email', Icons.email_outlined, false, _emailTextController),
                SizedBox(height: 20),
                textFieldWidget(
                    'Номер телефона', Icons.phone, false, _phoneTextController),
                SizedBox(height: 20),
                textFieldWidget('Придумайте пароль', Icons.lock, true,
                    _passwordTextController),
                SizedBox(height: 20),
                textFieldWidget('Подтверите пароль', Icons.lock, false,
                    _passwordCheckTextController),
                SizedBox(height: 30),

                // sign in button
                Padding(
                  padding:
                      const EdgeInsetsDirectional.symmetric(horizontal: 25),
                  child: GestureDetector(
                    onTap: signUp,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Text(
                          'Регистрация',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
