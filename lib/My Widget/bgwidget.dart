import 'package:flutter/material.dart';

Widget bgWidget({Widget? child}){
  return Container(
    decoration: BoxDecoration(
      image: DecorationImage(image: AssetImage('asset/background/loginPoke.png'), fit: BoxFit.fitWidth)
    ),
    child: child,
  );
}

Widget profileBGWidget({Widget? child}){
  return Container(
    decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage('asset/background/ProfileBG.png'), fit: BoxFit.fitWidth)
    ),
    child: child,
  );
}

Widget UserBG({Widget? child}){
  return Container(
    decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage('asset/background/UserBG.png'), fit: BoxFit.fitWidth)
    ),
    child: child,
  );
}

Widget overallBG({Widget? child}){
  return Container(
    decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage('asset/background/overallBG.png'), fit: BoxFit.fitWidth)
    ),
    child: child,
  );
}