import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../helpers/shared_preference.dart';

final String? baseURL = dotenv.env['URL'];
final String? registerToken = dotenv.env['REGISTER_TOKEN'];

class AuthenticationProvider with ChangeNotifier {
  bool _isAuthenticated = false;
  late Map<String, dynamic>? _currentUser;
  late String? _token;

  bool get isAuthenticated {
    return _isAuthenticated;
  }

  Map<String, dynamic>? get currentUser {
    return _currentUser;
  }

  Future<void> login(String? email, String? password) async {
    try {
      if (email != null && password != null) {
        final UserCredential result = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);

        String _token = await result.user!.getIdToken(true);

        await SharedPreferenceController()
              .setString('token', _token.toString());

        if (baseURL != null) {
          final Uri url = Uri.parse('$baseURL/users/me');

          Map<String, String> requestHeaders = {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $_token'
          };

          final userResult = await http.get(url, headers: requestHeaders);

          final user = json.decode(userResult.body);

          _currentUser = user['data'];

          if (_currentUser != null && _token != null) {
            _isAuthenticated = true;
          }
        } else {
          print('dfsd');
          _isAuthenticated = false;
        }
      }
    } catch (error) {
      print(error);
    }
    notifyListeners();
  }

  Future<void> signup(Map<String, String> signupData) async {
    try {
      if (baseURL != null && registerToken != null) {
        final Uri url = Uri.parse('$baseURL/users');

        Map<String, String> requestHeaders = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $registerToken'
        };

        final result = await http.post(
          url,
          body: json.encode(signupData),
          headers: requestHeaders,
        );

        final decodedResult = json.decode(result.body);

        print(decodedResult);

        if (decodedResult['uri'] != null) {
          await login(signupData['login'], signupData['password']);
        }
      }
    } catch (error) {
      print(error);
    }

    notifyListeners();
  }

  logout() async {
    try {
      await FirebaseAuth.instance.signOut();

      _currentUser = null;
      _token = null;
      _isAuthenticated = false;

      SharedPreferenceController().clearAll();
    } catch (error) {
      print(error);
    }

    notifyListeners();
  }
}
