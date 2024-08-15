import 'package:flutter/material.dart';
class ButtonRounded extends StatelessWidget {
  const ButtonRounded({
    super.key,
    this.text="Button",
    this.backgroundColor=Colors.black,
    this.textColor=Colors.white,
  });

  final String text;
  final Color backgroundColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: backgroundColor,
      ),
      // width: MediaQuery.sizeOf(context).width,
      // margin: EdgeInsets.all(20.0),
      padding: EdgeInsets.all(20.0),
      width: double.infinity,
      child: Text(text, style: TextStyle(color: textColor, fontSize: 20.0, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
    );
  }
}
