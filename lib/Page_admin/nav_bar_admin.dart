import 'package:flutter/material.dart';
import 'package:frontend/Page_admin/Show_All_Poke.dart';
import 'package:frontend/Page_admin/add_item.dart';
import 'package:frontend/Page_admin/profile_admin.dart';


class NavBarAdmin extends StatefulWidget {
  const NavBarAdmin({super.key});

  @override
  State<NavBarAdmin> createState() => _NavBarAdminState();
}

class _NavBarAdminState extends State<NavBarAdmin> {
  @override
  int index = 0;
  final screen = const [
    AllItem(),
    addItem(),
    MainProfileAdmin()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: screen[index],
        bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(
              backgroundColor: Colors.blue.shade50,
              indicatorColor: Colors.white,
              labelTextStyle: MaterialStateProperty.all(const TextStyle(fontSize: 14, fontWeight: FontWeight.w500))
          ),
          child: NavigationBar(
              height: 60,
              selectedIndex: index,
              onDestinationSelected: (index) => setState(() => this.index = index),
              destinations: const [
                NavigationDestination(icon: Icon(Icons.collections_bookmark_rounded), label: 'ITEM'),
                NavigationDestination(icon: Icon(Icons.add), label: 'ADD ITEM'),
                NavigationDestination(icon: Icon(Icons.person_outline_rounded), label: 'PROFILE'),
              ]
          ),
        )
    );
  }
}
