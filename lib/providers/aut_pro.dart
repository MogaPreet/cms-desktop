import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  bool loading = false;
  bool get isLoading => loading;

  String error = '';
  String get getError => error;

  seterror(String val) {
    error = val;
    notifyListeners();
  }

  setload(bool val) {
    loading = val;
    notifyListeners();
  }

  Future<void> loginUser(
    String email,
    String password,
    BuildContext context,
  ) async {
    final auth = FirebaseAuth.instance;
    setload(true);

    try {
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => {
                setload(false),
                seterror('success'),
                Navigator.pushReplacementNamed(context, '/dashboard')
              })
          .catchError((error) {
        seterror(error.toString());

        setload(false);
      });
    } catch (error) {
      setload(false);
      print(error);
    }
  }
}
