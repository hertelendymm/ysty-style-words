import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppBarSecondary extends StatelessWidget {
  const AppBarSecondary(
      {super.key, required this.onPressed, required this.title});

  final String title;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => onPressed(),
                  // onTap: () => closePage(),
                  child: Container(
                      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 11.0, 10.0),
                      child: Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                            color: Colors.grey.shade200,
                          ),
                          child: const Icon(FontAwesomeIcons.xmark,
                              size: 24.0,
                              color: Colors.black))),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 0.0, vertical: 6.0),
                    child: Center(
                      child: Text(
                        title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24.0),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 45.0)
              ],
            ),
          ),
          // const SizedBox(height: 0.0),
          Container(color: Colors.grey.shade200, height: 2.0),
        ],
      ),
    );
  }
}
