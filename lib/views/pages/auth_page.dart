import 'package:flutter/material.dart';
import 'package:shooppyy/utilities/enums.dart';
import 'package:shooppyy/views/widgets/main_button.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  var _authType = AuthFormType.login;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 32.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _authType == AuthFormType.login ? 'Login' : 'Register',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(height: 64),
                TextFormField(
                  controller: _email,
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
                SizedBox(height: 24),
                if (_authType == AuthFormType.login)
                  Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      child: Text('Forgot your password?'),
                      onTap: () {},
                    ),
                  ),
                SizedBox(height: 24),
                MainButton(
                    text:
                        _authType == AuthFormType.login ? 'Login' : 'Register',
                    onTap: () {}),
                SizedBox(height: 16),
                Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    child: Text(_authType == AuthFormType.login
                        ? 'Don\'t have an account? Register'
                        : 'Already have an account ? Login'),
                    onTap: () {
                      setState(() {
                        if (_authType == AuthFormType.login) {
                          _authType = AuthFormType.register;
                        } else {
                          _authType = AuthFormType.login;
                        }
                      });
                    },
                  ),
                ),
                Spacer(),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    _authType == AuthFormType.login
                        ? 'Or login with'
                        : 'Or Register with',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white,
                      ),
                      child: Icon(Icons.facebook),
                    ),
                    SizedBox(width: 10),
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white,
                      ),
                      child: Icon(Icons.telegram),
                    ),
                  ],
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
