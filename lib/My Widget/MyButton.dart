import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final void Function()? onTap;
  final String Text_on_button;
  final Color buttonColor;
  final double sizeX;
  const MyButton({super.key, required this.onTap, required this.buttonColor, required this.Text_on_button, required this.sizeX});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      child: Container(
          width: width*sizeX,
          height: height*0.05,
          decoration: BoxDecoration(
          color: buttonColor,
            borderRadius: BorderRadius.circular(5)
        ),
          child: Center(
              child: Text(Text_on_button, style: TextStyle(color: Colors.white, fontSize: 16),)
          )
      ),
    );
  }
}
