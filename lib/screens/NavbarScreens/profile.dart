import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          CircleAvatar(
            radius: 50,
            child: Icon(
              Icons.person,
              size: 80,
            ),
          ),
          SizedBox(
            height: 40,
          ),
          ListTile('Username', 'player456'),
          ListTile('PhoneNumber', '+23480505050'),
          ListTile('Interest', 'Football'),
        ],
      ),
    );
  }
}

class ListTile extends StatelessWidget {
  final String? headText;
  final String? titleText;
  const ListTile(
    this.headText,
    this.titleText,
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                headText!,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: Color(0XFF78B833),
                ),
              ),
              const SizedBox(height: 15),
              Text(
                titleText!,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
