import 'package:flutter/material.dart';

Widget bgWidget({Widget? child}){
  return Container(
    decoration: BoxDecoration(
      image: DecorationImage(image: AssetImage('asset/background/loginPoke.png'), fit: BoxFit.fitWidth)
    ),
    child: child,
  );
}