// ignore_for_file: avoid_print

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class AuthProvider with ChangeNotifier {
  bool _loading = false;
  bool _obscure = false;

  bool get loading => _loading;
  bool get obscure => _obscure;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  setObscure(bool value) {
    _obscure = value;
    notifyListeners();
  }

  void login(String email, String password) async {
    setLoading(true);
    try {
      Response response =
          await post(Uri.parse("https://reqres.in/api/login"), body: {
        'email': email,
        'password': password,
      });
      if (response.statusCode == 200) {
        print('successfull');
        setLoading(false);
      } else {
        print("failed");
        setLoading(false);
      }
    } catch (e) {
      print(e.toString());
      setLoading(false);
    }
  }
}
