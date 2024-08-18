import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ysty_style_words/pages/categories_page.dart';
import 'package:ysty_style_words/pages/profile_page.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: kToolbarHeight + 10,
          child: AppBar(
            backgroundColor: Colors.white,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CategoriesPage())),
                    child: Container(
                      // height: 40.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(color: Colors.grey.shade300, width: 3),
                      ),
                      padding:
                          const EdgeInsets.symmetric(horizontal: 0.0, vertical: 6.0),
                      // padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: const Center(
                          child: Text(
                        "Category Name",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                        textAlign: TextAlign.center,
                      )),

                      /// TODO: From SharedPreference load the lest chosen category title!!!
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                GestureDetector(
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const ProfilePage())),
                  child: Container(
                    // color: Colors.red,
                    padding:
                    const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                        // const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                          color: Colors.grey.shade200),
                      child: const Icon(FontAwesomeIcons.gear, color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          color: Colors.grey.shade200,
          height: 2.0,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight+12);
}
