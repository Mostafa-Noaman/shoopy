import 'package:flutter/material.dart';
import 'package:shooppyy/controllers/database_controller.dart';
import 'package:shooppyy/models/user_model.dart';
import 'package:shooppyy/services/auth.dart';
import 'package:shooppyy/utilities/constants.dart';
import 'package:shooppyy/utilities/enums.dart';

class AuthController with ChangeNotifier {
  final AuthBase auth;
  String email;
  String password;
  AuthFormType authFormType;
  final database = FireStoreDatabase('123');

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
        final user = await auth.signUpWithEmailAndPassword(email, password);
        await database.setUserData(UserModel(
            uId: user?.uid ?? documentIdFromLocalData(), email: email));
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
