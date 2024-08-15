import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ysty_style_words/pages/derdiedas_help_page.dart';
import 'package:ysty_style_words/pages/profile_page.dart';
import 'package:ysty_style_words/widgets/button_rounded.dart';

import 'categories_page.dart';

class DerDieDasPage extends StatefulWidget {
  const DerDieDasPage({super.key});

  @override
  State<DerDieDasPage> createState() => _DerDieDasPageState();
}

class _DerDieDasPageState extends State<DerDieDasPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfilePage())),
                child: const Icon(FontAwesomeIcons.user)),
            const SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CategoriesPage())),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(color: Colors.grey, width: 3),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: const Text(
                    "Category",
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10.0,
            ),
            GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DerDieDasHelpPage())),
                child: const Icon(FontAwesomeIcons.lightbulb)),
          ],
        ),
        // centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 80.0),
                margin: EdgeInsets.symmetric(horizontal: 0.0, vertical: 20.0),
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(color: Colors.grey.shade300, width: 3),
                    color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('________',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 40.0)),
                    Text('Krankenwagen',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 40.0)),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(child: ButtonRounded(text: "der")),
                  SizedBox(width: 20.0),
                  Expanded(child: ButtonRounded(text: "die")),
                  SizedBox(width: 20.0),
                  Expanded(child: ButtonRounded(text: "das")),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
