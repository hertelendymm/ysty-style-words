import 'package:flutter/material.dart';

class ButtonNavigation extends StatelessWidget {
  const ButtonNavigation({
    super.key,
    this.isActive = false,
    required this.onPressed,
  });

  final bool isActive;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => onPressed(),
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100.0),
              color: isActive ? Colors.orange.shade600 : Colors.grey.shade400,
            ),
            width: 40.0,
            height: 40.0));
  }
}
