import 'package:flutter/material.dart';

class AllItem extends StatefulWidget {
  const AllItem({super.key});

  @override
  State<AllItem> createState() => _AllItemState();
}

class _AllItemState extends State<AllItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("ALL ITEM", style: TextStyle(color: Colors.black),),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),

    );
  }
}
