
import 'package:flutter/material.dart';
import 'package:frontend/Page_admin/profile_admin.dart';
import 'package:frontend/Page_user/home_page.dart';
import 'package:frontend/Page_user/profile_user.dart';
import 'package:frontend/page/search.dart';

class BottomNavBar extends StatefulWidget {
  final int index;
  const BottomNavBar({Key?key, required this.index}): super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  late int index;
  final screen = const [
    HomePage(),
    SearchPage(),
    MainProfileUser(),
  ];

  @override
  void initState() {
    super.initState();
    index=widget.index;
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: screen[index],
        bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(
              backgroundColor: Colors.blue.shade50,
              indicatorColor: Colors.white,
              labelTextStyle: MaterialStateProperty.all(const TextStyle(fontSize: 14, fontWeight: FontWeight.w500))
          ),
          child: NavigationBar(
              height: height*0.08,
              selectedIndex: index,
              onDestinationSelected: (index) => setState(() => this.index = index),
              destinations: const [
                NavigationDestination(icon: Icon(Icons.home_outlined), label: 'HOME'),
                NavigationDestination(icon: Icon(Icons.search), label: 'SEARCH'),
                NavigationDestination(icon: Icon(Icons.person_outline_rounded), label: 'PROFILE'),
              ]
          ),
        )
    );
  }
}