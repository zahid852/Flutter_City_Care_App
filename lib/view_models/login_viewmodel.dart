import 'package:city_care/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

class LoginViewModel extends ChangeNotifier {
  String message = '';
  Future<bool> login(String email, String password) async {
    bool isLogedIn = false;
    try {
      print('email $email');
      print('password $password');
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      print('hlo');
      isLogedIn = userCredential != null;
    } on FirebaseAuthException catch (error) {
      message = error.code;
      notifyListeners();
    } catch (error) {
      message = error.toString();
      notifyListeners();
    }
    return isLogedIn;
  }
}
