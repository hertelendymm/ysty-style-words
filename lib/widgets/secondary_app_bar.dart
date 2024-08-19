import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SecondaryAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SecondaryAppBar({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          AppBar(
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            scrolledUnderElevation: 0.0,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    // color: Colors.red,
                    padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                    // const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        color: Colors.grey.shade200,
                      ),
                      child:
                          const Icon(FontAwesomeIcons.xmark, color: Colors.black),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 40.0,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 0.0, vertical: 6.0),
                    child: Center(
                        child: Text(
                      title,
                      style:
                          const TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
                      textAlign: TextAlign.center,
                    )),
                  ),
                ),
                const SizedBox(width: 45.0),
              ],
            ),
          ),
          const SizedBox(height: 20.0),
          Container(
            color: Colors.grey.shade200,
            height: 2.0,
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 22);
}
