import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:sport_connect/screens/NavbarScreens/buddies.dart';
import 'package:sport_connect/screens/NavbarScreens/discover.dart';
import 'package:sport_connect/screens/NavbarScreens/profile.dart';
import 'package:sport_connect/screens/NavbarScreens/settings.dart';

class MainScreen extends StatefulWidget {
  static const routeName = 'main-screen';
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  List<Widget> pageList = <Widget>[];

  @override
  void initState() {
    super.initState();
    pageList.add(const Profile());
    pageList.add(const Buddies());
    pageList.add(const Discover());
    pageList.add(const Settings());
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    String title;
    switch (_selectedIndex) {
      case 0:
        title = 'Profile';
        break;
      case 1:
        title = 'Buddies';
        break;
      case 2:
        title = 'Discover';
        break;
      default:
        title = 'Settings';
        break;
    }
    return Scaffold(
     
      bottomNavigationBar: BottomNavigationBar(
        elevation: 5,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(
              icon: Icon(Icons.people_alt_outlined), label: 'Buddies'),
          BottomNavigationBarItem(
              icon: Icon(Icons.search), label: 'Discover'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        backgroundColor: Colors.white,
        systemOverlayStyle: const SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.white,
          statusBarColor: Colors.white,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarDividerColor: Colors.white,
          //Navigation bar divider color
          systemNavigationBarIconBrightness:
              Brightness.light, //navigation bar icon
        ),
        title: Text(
          title,
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),
        ),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: pageList,
      ),
    );
  }
}
