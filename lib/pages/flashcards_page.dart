import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ysty_style_words/pages/profile_page.dart';
import 'package:ysty_style_words/widgets/button_rounded.dart';

import 'categories_page.dart';

class FlashcardsPage extends StatefulWidget {
  const FlashcardsPage({super.key});

  @override
  State<FlashcardsPage> createState() => _FlashcardsPageState();
}

class _FlashcardsPageState extends State<FlashcardsPage> {
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
                onTap: () {}, child: const Icon(FontAwesomeIcons.rotate)),
          ],
        ),
        // centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 100.0),
              margin: EdgeInsets.symmetric(horizontal: 0.0, vertical: 20.0),
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(color: Colors.grey.shade300, width: 3),
                  color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('der',
                      style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20.0)),
                  SizedBox(height: 40.0),
                  Text('Frühling',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50.0)),
                  SizedBox(height: 40.0),
                  Text('Im Frühling blühen die Blumen.',
                      style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20.0)),
                ],
              ),
            ),
            Text('Swipe right if you know it, swipe left if you need more practice and tap the card to see the other side',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0), textAlign: TextAlign.center,),
            Row(
              children: [
                Expanded(child: ButtonRounded(text: "Don't know", onPressed: (){})),
                SizedBox(width: 20.0),
                Expanded(child: ButtonRounded(text: "Know it", onPressed: (){})),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
