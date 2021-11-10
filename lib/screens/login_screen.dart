import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sport_connect/provider/service.dart';
import 'package:sport_connect/screens/forgot_password_screen.dart';
import 'package:sport_connect/screens/main_screen.dart';
import 'package:sport_connect/widgets/UI/back_button.dart';
import 'package:sport_connect/widgets/UI/clip_design.dart';
import 'package:sport_connect/widgets/login_form.dart';

import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = 'user-login-screen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var _isLoading = false;
  void _submitAuthForm(
    String email,
    String password,
    BuildContext ctx,
  ) async {
    try {
      setState(() {
        _isLoading = true;
      });
      await Provider.of<Service>(context, listen: false)
          .signIn(email, password);
      Navigator.of(context).pushNamedAndRemoveUntil(
          MainScreen.routeName, (Route<dynamic> route) => false);
      // Navigator.of(context).pushNamedAndRemoveUntil(
      //     AdminScreen.routeName, (Route<dynamic> route) => false);
    } catch (err) {
      print(err);
      setState(() {
        _isLoading = false;
      });
      final snack = ScaffoldMessenger.of(context);
      snack.hideCurrentSnackBar();
      snack.showSnackBar(
        const SnackBar(
          backgroundColor: Color(0XFF78B833),
          content: Text('An Error occurred'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            const ClipDesign(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: height * .2),
                    RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        text: 'Sign ',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          color: Color(0XFF78B833),
                        ),
                        children: [
                          TextSpan(
                            text: 'In',
                            style: TextStyle(
                                color: Color(0XFF78B833), fontSize: 30),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 50),
                    LoginForm(
                      isLoading: _isLoading,
                      submitFn: _submitAuthForm,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(ForgotPassword.routeName);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        alignment: Alignment.centerRight,
                        child: const Text('Forgot Password ?',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500)),
                      ),
                    ),
                    SizedBox(height: height * .055),
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushReplacementNamed(SignUpScreen.routeName);
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        padding: const EdgeInsets.all(15),
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const <Widget>[
                            Text(
                              'Don\'t have an account ?',
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Register',
                              style: TextStyle(
                                  color: Color(0XFF78B833),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const BackPathButton(),
          ],
        ),
      ),
    );
  }
}
