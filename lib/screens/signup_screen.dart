import 'package:flutter/material.dart';
import 'package:sport_connect/screens/otp_screen.dart';

import 'package:sport_connect/widgets/UI/back_button.dart';
import 'package:sport_connect/widgets/UI/clip_design.dart';
import 'package:sport_connect/widgets/signup_form.dart';

import '../widgets/UI/back_button.dart';
import './login_screen.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = 'user-signup-screen';

  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var _isLoading = false;
  void _submitAuthForm(
    String email,
    String password,
    String phoneNumber,
    String interest,
  ) async {
    try {
      // setState(() {
      //   _isLoading = true;
      // });
      // //   await Provider.of<Service>(context, listen: false)
      // // .signIn(email, password, true);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Otp(
            email: email,
            password: password,
            phoneNumber: phoneNumber,
            interest: interest,
          ),
        ),
      );
      // setState(() {
      //   _isLoading = false;
      // });
      // Navigator.of(context).pushNamedAndRemoveUntil(
      //     AdminScreen.routeName, (Route<dynamic> route) => false);
    } catch (err) {
      print(err);
      setState(() {
        _isLoading = false;
      });
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
                            text: 'Up',
                            style: TextStyle(
                                color: Color(0XFF78B833), fontSize: 30),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    SignupForm(
                      isLoading: _isLoading,
                      submitFn: _submitAuthForm,
                    ),
                    const SizedBox(height: 5),
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushReplacementNamed(LoginScreen.routeName);
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        padding: const EdgeInsets.all(15),
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const <Widget>[
                            Text(
                              'Already have an account ?',
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Login',
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
