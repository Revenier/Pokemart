import 'package:flutter/material.dart';

class ElementButton extends StatelessWidget {

  final void Function()? onTap;
  final String Text_on_button;
  final String textColor;
  const ElementButton({super.key, required this.onTap, required this.textColor, required this.Text_on_button, });

  @override
  Widget build(BuildContext context) {
    int hex=int.parse(textColor);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      child: Container(
          height: height*0.05,
          decoration: BoxDecoration(
            color: Colors.white,
              borderRadius: BorderRadius.circular(10)
          ),
          child: Center(
              child: Container(
                  child: FittedBox(
                     child: Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Text(Text_on_button, style: TextStyle(color: Color(hex),fontWeight: FontWeight.w500, fontSize: 20),
                          ),
                     )
                  )
              )
          )
      ),
    );
  }
}
