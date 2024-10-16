import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:shooppyy/controllers/auth/auth_cubit.dart';
import 'package:shooppyy/utilities/constants.dart';
import 'package:shooppyy/utilities/router.dart';
import 'package:shooppyy/utilities/routes.dart';

void main() async {
  await initSetup();
  runApp(const MyApp());
}

Future<void> initSetup() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Stripe.publishableKey = AppConstants.publishableKey;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = AuthCubit();
        cubit.authStatus();
        return cubit;
      },
      child: Builder(builder: (context) {
        return BlocBuilder<AuthCubit, AuthState>(
          bloc: BlocProvider.of<AuthCubit>(context),
          buildWhen: (previous, current) =>
              current is AuthSuccess || current is AuthInitial,
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(
                useMaterial3: true,
                appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
                iconTheme: const IconThemeData(color: Colors.black),
                scaffoldBackgroundColor: const Color(0xFFE5E5E5),
                primaryColor: Colors.red,
                inputDecorationTheme: InputDecorationTheme(
                  labelStyle: Theme.of(context).textTheme.labelMedium,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2.0),
                    borderSide: const BorderSide(color: Colors.red),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2.0),
                    borderSide: const BorderSide(color: Colors.red),
                  ),
                ),
              ),
              onGenerateRoute: onGenerate,
              initialRoute: state is AuthSuccess
                  ? AppRoutes.bottomNavBarRoute
                  : AppRoutes.loginPageRoute,
            );
          },
        );
      }),
    );
  }
}
