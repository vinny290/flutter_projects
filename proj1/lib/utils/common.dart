import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class CommonUtil {
  static const String apiUrl = 'http://localhost:56274/';
  static const String stripeUserCreate = '/add/user';
  static const String checkout = '/checkout';

  static backendCall(User user, String endPoint) async {
    String token;

    try {
      token = (await user.getIdToken())!;
    } catch (e) {
      print('Ошибка получения токена: $e');
      return; // Возвращаемся, так как нет токена для отправки запроса
    }

    return http.post(Uri.parse(apiUrl + endPoint), headers: {
      "Accept": "application/json",
      "Content-type": "application/json",
      "Authorization": "Bearer $token",
    });
  }
}
