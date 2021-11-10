import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sport_connect/provider/service.dart';
import 'package:sport_connect/widgets/profile_menu.dart';
import '../home_screen.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      child: Column(
        children: [
          const SizedBox(height: 5),
          ProfileMenu(
            text: "Change Password",
            icon: Icons.password,
            press: () => {},
          ),
          ProfileMenu(
            text: "Update Email",
            icon: Icons.email,
            press: () {},
          ),
          ProfileMenu(
            text: "Update Username",
            icon: Icons.update_sharp,
            press: () {},
          ),
          ProfileMenu(
            text: "Logout",
            icon: Icons.logout,
            press: () {
              Provider.of<Service>(context, listen:false).signOut();
              Navigator.of(context).pushNamedAndRemoveUntil(
                  WelcomeScreen.routeName, (Route<dynamic> route) => false);
            },
          ),
        ],
      ),
    );
  }
}
