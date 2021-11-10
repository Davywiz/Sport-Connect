import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  final bool isLoading;
  final void Function(
    String email,
    String password,
    BuildContext ctx,
  ) submitFn;
  const LoginForm({Key? key, required this.isLoading, required this.submitFn})
      : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool showPassword = true;
  var userEmail = '';
  var userPassword = '';

  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState!.save();
      widget.submitFn(
        userEmail.trim(),
        userPassword.trim(),
        context,
      );
    }
  }

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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              _buildTextFormField(
                'Email',
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (value) {
                    userEmail = value!;
                  },
                  obscureText: false,
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
              _buildTextFormField(
                'Password',
                TextFormField(
                  obscureText: showPassword ? true : false,
                  onSaved: (value) {
                    userPassword = value!;
                  },
                  validator: (value) {
                    if (value!.isEmpty || value.length < 6) {
                      return 'Must be more than 6 characters.';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.visibility),
                      onPressed: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                    ),
                    border: InputBorder.none,
                    fillColor: const Color(0xfff3f3f4),
                    filled: true,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        GestureDetector(
          onTap: _trySubmit,
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(vertical: 15),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
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
            child: widget.isLoading
                ? const SizedBox(
                    height: 25,
                    width: 25,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 3,
                    ),
                  )
                : const Text(
                    'Login',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
          ),
        ),
      ],
    );
  }
}
