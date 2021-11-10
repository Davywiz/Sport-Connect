import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sport_connect/provider/service.dart';
import 'package:sport_connect/screens/home_screen.dart';
import 'package:sport_connect/screens/login_screen.dart';
import 'package:sport_connect/screens/main_screen.dart';
import 'package:sport_connect/screens/signup_screen.dart';

import 'screens/forgot_password_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //initialize firebase in app
  Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => Service(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Sport Connect',
        theme: ThemeData(
          primaryColor: const Color(0XFF78B833),
          primarySwatch: Colors.green,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: GoogleFonts.latoTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        home: const WelcomeScreen(),
        routes: {
          WelcomeScreen.routeName: (ctx) => const WelcomeScreen(),
          SignUpScreen.routeName: (ctx) => const SignUpScreen(),
          LoginScreen.routeName: (ctx) => const LoginScreen(),
          ForgotPassword.routeName: (ctx) => const ForgotPassword(),
          MainScreen.routeName: (ctx) => const MainScreen(),
        },
      ),
    );
  }
}
