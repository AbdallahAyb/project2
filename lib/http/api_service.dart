import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class APIService {
  static const String url = 'https://flutterproj12.000webhostapp.com';
  static String? currentUserId;

  static Future<bool> Login(String email, String password) async {
    try {
      final uri = Uri.parse('$url/login.php');
      final response = await http.post(uri,
          body: json.encode({'email': email, 'password': password}));
      final data = json.decode(response.body);
      if (data['result'] == false) return false;

      currentUserId = data['userId'].toString();
      return true;
    } catch (e) {
      print('Error during login: $e');
      return false;
    }
  }

  static Future<bool> Register(String email, String password) async {
    try {
      final uri = Uri.parse('$url/register.php');
      final response = await http.post(uri,
          body: json.encode({'email': email, 'password': password}));
      final data = json.decode(response.body);
      if (data['result'] == false) return false;
      currentUserId = data['userId'].toString();
      return true;
    } catch (e) {
      print('Error during registration: $e');
      return false;
    }
  }

  static Future<Response?> sendRequest(
      String method, String? jsonBody, String? overrideId) async {
    if (currentUserId == null) {
      print("YOU MUST LOGIN FIRST");
      return null;
    }

    final uri = Uri.parse('$url/todo.php?id=$currentUserId');
    if (method == 'DELETE') {
      final uri = Uri.parse('$url/todo.php?id=$overrideId');
      return await http.head(uri);
    }
    if (method == 'GET') {
      return await http.get(uri);
    } else if (method == 'POST') {
      return await http.post(uri, body: jsonBody);
    } else {
      return null;
    }
  }
}
