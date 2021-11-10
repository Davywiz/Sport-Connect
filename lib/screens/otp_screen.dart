import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sport_connect/provider/service.dart';
import 'package:sport_connect/screens/main_screen.dart';

class Otp extends StatefulWidget {
  static const routeName = 'otp-screen';
  final String email;
  final String password;
  final String phoneNumber;
  final String interest;
  const Otp(
      {Key? key,
      required this.email,
      required this.password,
      required this.phoneNumber,
      required this.interest})
      : super(key: key);

  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  var enteredValue = '';
  var isLoading = false;

  @override
  void initState() {
    super.initState();
    Provider.of<Service>(context, listen: false)
        .verifyNumber(widget.phoneNumber);
  }

//validate Otp and Login User
  void checkOtp() async {
    print(enteredValue);
    if (enteredValue.isEmpty || enteredValue.length <= 5) {
      return;
    }
    setState(() {
      isLoading = true;
    });
    try {
      await Provider.of<Service>(context, listen: false).signUp(
          enteredValue, widget.email, widget.phoneNumber, widget.password,widget.interest);
      Navigator.of(context).pushNamedAndRemoveUntil(
          MainScreen.routeName, (Route<dynamic> route) => false);
    } catch (err) {
      setState(() {
        isLoading = false;
      });
      print(err);
      final snack = ScaffoldMessenger.of(context);
      snack.hideCurrentSnackBar();
      snack.showSnackBar(
        const SnackBar(
          backgroundColor: Color(0XFF78B833),
          content: Text('An Error occurred, please go back and try again.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xfff7f6fb),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(
                              left: 0, top: 10, bottom: 10),
                          child: const Icon(
                            Icons.keyboard_arrow_left,
                            color: Colors.black,
                          ),
                        ),
                        const Text(
                          'Back',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              Container(
                width: 200,
                height: 200,
                decoration: const BoxDecoration(
                  color: Color(0XFF78B833),
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  'assets/images/phone_logo.png',
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              const Text(
                'Verification',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Enter your OTP code number",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 28,
              ),
              Container(
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _textFieldOTP(first: true, last: false),
                        _textFieldOTP(first: false, last: false),
                        _textFieldOTP(first: false, last: false),
                        _textFieldOTP(first: false, last: false),
                        _textFieldOTP(first: false, last: false),
                        _textFieldOTP(first: false, last: true),
                      ],
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: checkOtp,
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color(0XFF78B833)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: isLoading
                              ? const SizedBox(
                                  height: 25,
                                  width: 25,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 3,
                                  ),
                                )
                              : const Text(
                                  'Verify',
                                  style: TextStyle(fontSize: 16),
                                ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              const Text(
                "Didn't you receive any code?",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 18,
              ),
              const Text(
                "Resend New Code",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0XFF78B833),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _textFieldOTP({bool? first, last}) {
    return Container(
      height: 85,
      width: 40,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: TextField(
          autofocus: true,
          onChanged: (value) {
            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            }
            if (value.length == 0 && first == false) {
              FocusScope.of(context).previousFocus();
            }
            setState(() {
              if (enteredValue.length < 6) {
                enteredValue += value;
                print(enteredValue);
              }
            });
          },
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            counter: const Offstage(),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 2, color: Colors.black12),
                borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(width: 2, color: Color(0XFF78B833)),
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    );
  }
}
