import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ysty_style_words/widgets/title_w_sparator.dart';

class DerDieDasHelpPage extends StatelessWidget {
  const DerDieDasHelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _myAppBar(context),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(20.0),
                /// padding: const EdgeInsets.all(40.0), <-- The bigger padding looks better
                children: const [
                  Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
                  SizedBox(
                    height: 20.0,
                  ),
                  TitleWSeparator(title: "Der"),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Automarken"),
                      Text("\"Kalendar\""),
                      Text("\"Wetter\""),
                      Text("Alkoholsorten"),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TitleWSeparator(title: "Die"),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("-ung"),
                      Text("-heit"),
                      Text("-keit"),
                      Text("-schaft"),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TitleWSeparator(title: "Das"),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("-um"),
                      Text("-chen"),
                      Text("-lein"),
                      Text("Chemische Elemente"),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _myAppBar(context){
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
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    // color: Colors.red,
                    padding:
                    const EdgeInsets.symmetric(vertical: 0.0),
                    // const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        color: Colors.grey.shade200,
                      ),
                      child: const Icon(FontAwesomeIcons.xmark,
                          color: Colors.black),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    // height: 40.0,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 0.0, vertical: 6.0),
                    child: const Center(
                        child: Text(
                          "Der/Die/Das Help",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24.0),
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


}
