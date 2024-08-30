import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class ButtonRounded extends StatelessWidget {
  const ButtonRounded({
    super.key,
    this.text="Button",
    this.backgroundColor=Colors.black,
    this.textColor=Colors.white,
    required this.onPressed,
    this.isIconWText=false,
    this.iconData = FontAwesomeIcons.xmark,
  });

  final String text;
  final Color backgroundColor;
  final Color textColor;
  final Function onPressed;
  final bool isIconWText;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed(),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: backgroundColor,
        ),
        padding: const EdgeInsets.all(20.0),
        width: double.infinity,
        child: isIconWText ? Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(iconData, color: Colors.black),
            const SizedBox(width: 10.0),
            Text(text, style: TextStyle(color: textColor, fontSize: 20.0, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
          ],
        ): Text(text, style: TextStyle(color: textColor, fontSize: 20.0, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
      ),
    );
  }
}
