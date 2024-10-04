import 'package:flutter/material.dart';

class ButtonNavigation extends StatelessWidget {
  const ButtonNavigation({
    super.key,
    this.isActive = false,
    required this.onPressed,
    required this.iconData,
  });

  final bool isActive;
  final Function onPressed;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: GestureDetector(
          onTap: () => onPressed(),
          child: Container(
            // decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(10.0),
                // borderRadius: BorderRadius.circular(100.0),
                // color: isActive ? Colors.orange.shade600 : Colors.grey.shade400,
                // color: Colors.grey.shade400,
                // ),
            // width: 80.0,
            // color: Colors.grey.shade100,
            color: Colors.black,
            width: double.infinity,
            height: 60.0,
            child: Center(
                child: Container(
                  decoration: BoxDecoration(
                  // color: isActive ? Colors.blue.shade900 : Colors.grey.shade900,
                    // color: isActive ? Colors.black : Colors.transparent,
                  // color: isActive ? Colors.blue.shade900 : Colors.transparent,
                  // color: isActive ? Colors.blue.shade900 : Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                  width: 80.0,
                  height: 40.0,
                  child: Icon(iconData,
                      // color: isActive ? Colors.blue.shade200 : Colors.grey.shade600),
                      color: isActive ? Colors.white : Colors.grey.shade600),
                )),
          )),
    );
  }
}
