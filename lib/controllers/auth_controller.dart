import 'package:flutter/material.dart';
import 'package:shooppyy/services/auth.dart';
import 'package:shooppyy/utilities/enums.dart';

class AuthController with ChangeNotifier {
  final AuthBase auth;
  String email;
  String password;
  AuthFormType authFormType;

  AuthController({
    required this.auth,
    this.email = '',
    this.password = '',
    this.authFormType = AuthFormType.login,
  });

  void toggleFormType() {
    final formType = authFormType == AuthFormType.login
        ? AuthFormType.register
        : AuthFormType.login;
    copyWith(email: '', password: '', authFormType: formType);
  }

  void updateEmail(String email) => copyWith(email: email);

  void updatePassword(String password) => copyWith(password: password);

  Future<void> submit() async {
    try {
      if (authFormType == AuthFormType.login) {
        await auth.loginWithEmailAndPassword(email, password);
      } else {
        await auth.signUpWithEmailAndPassword(email, password);
      }
    } catch (e) {
      rethrow;
    }
  }

  void copyWith({
    String? email,
    String? password,
    AuthFormType? authFormType,
  }) {
    this.email = email ?? this.email;
    this.password = password ?? this.password;
    this.authFormType = authFormType ?? this.authFormType;
    notifyListeners();
  }
}
