import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ysty_style_words/pages/profile_page.dart';

import 'categories_page.dart';

class MatchingGamePage extends StatefulWidget {
  const MatchingGamePage({super.key});

  @override
  State<MatchingGamePage> createState() => _FlashcardsPageState();
}

class _FlashcardsPageState extends State<MatchingGamePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
                child: const Icon(FontAwesomeIcons.xmark)),
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
                onTap: () {},
                child: const Icon(FontAwesomeIcons.hourglassStart)),
          ],
        ),
        // centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    _gameCard(),
                    _gameCard(),
                    _gameCard(),
                    _gameCard(),
                    _gameCard(),
                  ],
                ),
                Column(
                  children: [
                    _gameCard(),
                    _gameCard(),
                    _gameCard(),
                    _gameCard(),
                    _gameCard(),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _gameCard(){
    return Container(
        width: 160.0,
        height: 80.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: Colors.grey, width: 3),
          color: Colors.white,
        ),
        margin: EdgeInsets.all(10.0));
  }
}
