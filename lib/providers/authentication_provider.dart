import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_config/flutter_config.dart';

final String baseURL = FlutterConfig.get('URL');
final String registerToken = FlutterConfig.get('REGISTER_TOKEN');

class AuthenticationProvider with ChangeNotifier {
  bool _isAuthenticated = false;
  late User? _currentUser;
  late String? _token;

  bool get isAuthenticated {
    return _isAuthenticated;
  }

  User? get currentUser {
    return _currentUser;
  }

  Future<void> login(String? email, String? password) async {
    try {
      if (email != null && password != null) {
        final result = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);

        _currentUser = result.user;
        _token = await result.user?.getIdToken();

        if (_currentUser != null && _token != null) {
          _isAuthenticated = true;
        }
      }
    } catch (error) {
      print(error);
    }
    notifyListeners();
  }

  Future<void> signup(Map<String, String> signupData) async {
    print(signupData['login']);
    try {
      final Uri url = Uri.parse('$baseURL/users');

      print(url);

      // final result = await http.post(url,
      //     body: json.encode(signupData),
      //     headers: {'Authorization': 'Bearer $registerToken'});

      //print(json.decode(result.body));

      // _currentUser = result.user;
      // _token = await result.user?.getIdToken();

      // if(_currentUser != null && _token != null) {
      //   _isAuthenticated = true;
      // }
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
    } catch (error) {
      print(error);
    }

    notifyListeners();
  }
}
