import 'package:firebase_auth/firebase_auth.dart';

class UserSingleton {
  static final UserSingleton _singleton = UserSingleton._internal();

  factory UserSingleton() {
    return _singleton;
  }

  UserSingleton._internal();

  User? _user;

  void setUser(User user) {
    _user = user;
  }

  User? get user => _user;

  static final UserSingleton instance = UserSingleton();
}
