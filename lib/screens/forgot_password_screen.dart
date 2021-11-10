import 'package:flutter/material.dart';
import 'package:sport_connect/widgets/UI/back_button.dart';
import 'package:sport_connect/widgets/UI/clip_design.dart';

class ForgotPassword extends StatefulWidget {
  static const routeName = 'forgot-password-screen';
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  var isLoading = false;
  var userEmail = '';

  Widget _buildTextFormField(String headText, TextFormField textFormField) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            headText,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(
            height: 10,
          ),
          textFormField,
        ],
      ),
    );
  }

  void _trySubmit(BuildContext context) {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState!.save();
      Future.delayed(const Duration(seconds: 1), () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Color(0XFF78B833),
            content: Text('Email has been sent'),
          ),
        );
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
                        text: 'Forgot ',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          color: Color(0XFF78B833),
                        ),
                        children: [
                          TextSpan(
                            text: 'Password',
                            style: TextStyle(
                                color: Color(0XFF78B833), fontSize: 30),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 50),
                    Form(
                      key: _formKey,
                      child: _buildTextFormField(
                        'Email',
                        TextFormField(
                          obscureText: false,
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (value) {
                            userEmail = value!;
                          },
                          validator: (value) {
                            bool emailValid = RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value!);
                            if (value.isEmpty || !emailValid) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              fillColor: Color(0xfff3f3f4),
                              filled: true),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () => _trySubmit(context),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.grey.shade200,
                                offset: const Offset(2, 4),
                                blurRadius: 5,
                                spreadRadius: 2)
                          ],
                          gradient: const LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Color(0XFF78B833),
                              Color(0XFF78B833),
                            ],
                          ),
                        ),
                        child: isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white)
                            : const Text(
                                'Reset Password',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
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
