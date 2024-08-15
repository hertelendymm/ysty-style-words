import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ysty_style_words/widgets/button_rounded.dart';

import 'categories_page.dart';
import 'matching_game_page.dart';

class MatchingPage extends StatefulWidget {
  const MatchingPage({super.key});

  @override
  State<MatchingPage> createState() => _MatchingPageState();
}

class _MatchingPageState extends State<MatchingPage> {
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
                onTap: (){},
                child: const Icon(FontAwesomeIcons.user)
            ),
            const SizedBox(width: 10.0,),
            Expanded(
              child: GestureDetector(
                onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context) => const CategoriesPage())),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(color: Colors.grey, width: 3),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: const Text("Category", style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                ),
              ),
            ),
            const SizedBox(width: 35.0,),
            // GestureDetector(
            //     onTap: (){},
            //     child: const Icon(FontAwesomeIcons.gear)
            // ),
          ],
        ),
        // centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text('Match the words to their pairs!',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26.0)),
                  SizedBox(height: 20.0),
                  Text('High Score: 75',
                      style: TextStyle(fontWeight: FontWeight.normal, fontSize: 24.0, color: Colors.grey)),
                ],
              ),
              Container(
                height: 300,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(250.0), // Half the height for a circular shape
                  color: Colors.grey,
                ),
                // child: Text('asd'),
              ),
              ButtonRounded(text: "Start Game", onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context) => const MatchingGamePage()))),
            ],
          ),
        ),
      ),
    );
  }
}
