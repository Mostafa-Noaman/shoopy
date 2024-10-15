import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shooppyy/services/auth_services.dart';
import 'package:shooppyy/utilities/enums.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final authServices = AuthServicesImpl();
  var authFormType = AuthFormType.login;

  Future<void> signUP(String email, String password) async {
    emit(AuthLoading());
    try {
      final user =
          await authServices.signUpWithEmailAndPassword(email, password);
      if (user != null) {
        emit(AuthSuccess());
      } else {
        emit(AuthFailed('Incorrect credential'));
      }
    } catch (e) {
      emit(
        AuthFailed(e.toString()),
      );
    }
  }

  Future<void> signIn(String email, String password) async {
    emit(AuthLoading());
    try {
      final user =
          await authServices.loginWithEmailAndPassword(email, password);
      if (user != null) {
        emit(AuthSuccess());
      } else {
        emit(AuthFailed('Incorrect credential'));
      }
    } catch (e) {
      emit(
        AuthFailed(e.toString()),
      );
    }
  }

  void authStatus() {
    final user = authServices.currentUser;
    if (user != null) {
      emit(AuthSuccess());
    } else {
      emit(AuthInitial());
    }
  }

  Future<void> logout() async {
    emit(AuthLoading());
    try {
      await authServices.logout();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  void toggleFormType() {
    final formType = authFormType == AuthFormType.login
        ? AuthFormType.register
        : AuthFormType.login;
    emit(ToggleFormType(formType));
  }
}
