import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ysty_style_words/widgets/secondary_app_bar.dart';

class DerDieDasHelpPage extends StatelessWidget {
  const DerDieDasHelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: const SecondaryAppBar(title: "Der/Die/Das Help"),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20.0),
          // padding: const EdgeInsets.all(40.0),
          /// TODO: The bigger padding looks better
          children: [
            const Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
            const SizedBox(height: 20.0,),
            Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2.0),
                  border: Border.all(color: Colors.grey, width: 3),
                ),
                child: const Text(
                  'der',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                )),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Automarken"),
                Text("\"Kalendar\""),
                Text("\"Wetter\""),
                Text("Alkoholsorten"),
              ],
            ),
            const SizedBox(height: 20.0,),
            Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2.0),
                  border: Border.all(color: Colors.grey, width: 3),
                ),
                child: const Text(
                  'die',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                )),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("-ung"),
                Text("-heit"),
                Text("-keit"),
                Text("-schaft"),
              ],
            ),
            const SizedBox(height: 20.0,),
            Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2.0),
                  border: Border.all(color: Colors.grey, width: 3),
                ),
                child: const Text(
                  'das',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                )),
            const Column(
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
    );
  }
}
