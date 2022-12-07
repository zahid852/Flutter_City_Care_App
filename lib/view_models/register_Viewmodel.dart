import 'package:city_care/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

class registerViewModel extends ChangeNotifier {
  String message = '';
  Future<bool> register(String email, String password) async {
    bool isRegister = false;
    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      isRegister = userCredential != null;
    } on FirebaseAuthException catch (error) {
      if (error.code == 'weak-password') {
        message = Constants.WEAK_PASSWORD;
      } else if (error.code == 'email-already-in-use') {
        message = Constants.EMAIL_ALREADY_IN_USE;
      }
      notifyListeners();
    } catch (error) {
      message = error.toString();
      notifyListeners();
    }
    return isRegister;
  }
}
