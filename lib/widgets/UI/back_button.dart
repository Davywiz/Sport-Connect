import 'package:flutter/material.dart';

class BackPathButton extends StatelessWidget {
  const BackPathButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 40,
      left: 0,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(left: 0, top: 10, bottom: 10),
                child: const Icon(
                  Icons.keyboard_arrow_left,
                  color: Colors.black,
                ),
              ),
              const Text(
                'Back',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
