import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sport_connect/widgets/customClipper.dart';

class ClipDesign extends StatelessWidget {
  const ClipDesign({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -MediaQuery.of(context).size.height * .15,
      right: -MediaQuery.of(context).size.width * .4,
      child: Container(
          child: Transform.rotate(
        angle: -pi / 3.5,
        child: ClipPath(
          clipper: ClipPainter(),
          child: Container(
            height: MediaQuery.of(context).size.height * .5,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0XFF78B833),
                  Color(0xffffffff),
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}
