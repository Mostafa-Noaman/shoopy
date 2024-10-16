import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shooppyy/controllers/auth/auth_cubit.dart';
import 'package:shooppyy/utilities/enums.dart';
import 'package:shooppyy/utilities/routes.dart';
import 'package:shooppyy/views/widgets/main_button.dart';
import 'package:shooppyy/views/widgets/main_dialog.dart';

import '../../utilities/app_assets.dart';
import '../widgets/social_login_button.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final authCubit = BlocProvider.of<AuthCubit>(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 60.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    authCubit.authFormType == AuthFormType.login
                        ? 'Login'
                        : 'Register',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 80),
                  TextFormField(
                    controller: _email,
                    focusNode: _emailFocusNode,
                    onEditingComplete: () =>
                        FocusScope.of(context).requestFocus(_passwordFocusNode),
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'email can\'t be empty';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      hintText: 'Enter your email',
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _password,
                    focusNode: _passwordFocusNode,
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'password can\'t be empty';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      hintText: 'Enter your password',
                    ),
                  ),
                  const SizedBox(height: 24),
                  if (authCubit.authFormType == AuthFormType.login)
                    Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        child: const Text('Forgot your password?'),
                        onTap: () {},
                      ),
                    ),
                  const SizedBox(height: 24),
                  BlocConsumer<AuthCubit, AuthState>(
                    bloc: authCubit,
                    listenWhen: (previous, current) =>
                        current is AuthFailed || current is AuthSuccess,
                    listener: (context, state) {
                      if (state is AuthFailed) {
                        MainDialog(
                          context: context,
                          title: 'Error!',
                          content: state.error,
                        ).showAlertDialog();
                      } else if (state is AuthSuccess) {
                        Navigator.of(context)
                            .pushReplacementNamed(AppRoutes.bottomNavBarRoute);
                      }
                    },
                    buildWhen: (previous, current) =>
                        current is AuthSuccess ||
                        current is AuthFailed ||
                        current is AuthLoading ||
                        current is AuthInitial,
                    builder: (context, state) {
                      if (state is AuthLoading) {
                        return MainButton(
                          child: const CircularProgressIndicator.adaptive(),
                        );
                      }
                      return MainButton(
                          text: authCubit.authFormType == AuthFormType.login
                              ? 'Login'
                              : 'Register',
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              authCubit.authFormType == AuthFormType.login
                                  ? await authCubit.signIn(
                                      _email.text, _password.text)
                                  : await authCubit.signUP(
                                      _email.text, _password.text);
                            }
                          });
                    },
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      child: Text(authCubit.authFormType == AuthFormType.login
                          ? 'Don\'t have an account? Register'
                          : 'Already have an account ? Login'),
                      onTap: () {
                        _formKey.currentState!.reset();
                        authCubit.toggleFormType();
                      },
                    ),
                  ),
                  SizedBox(height: size.height * 0.1),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      authCubit.authFormType == AuthFormType.login
                          ? 'Or login with'
                          : 'Or Register with',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SocialMediaButton(
                        iconName: AppAssets.facebookIcon,
                        onPress: () {},
                      ),
                      const SizedBox(width: 16),
                      SocialMediaButton(
                        iconName: AppAssets.googleIcon,
                        onPress: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
