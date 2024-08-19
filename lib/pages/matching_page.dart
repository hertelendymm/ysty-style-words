import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ysty_style_words/widgets/button_rounded.dart';
import 'package:ysty_style_words/widgets/main_app_bar.dart';

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
      appBar: MainAppBar(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  // Text('Match the words to their pairs!',
                  Text('Time Trial',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40.0), textAlign: TextAlign.center,),
                  SizedBox(height: 20.0),
                  Text('How many matches can you make in two minutes? Let\'s find out!',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0), textAlign: TextAlign.center,),
                  SizedBox(height: 20.0),
                  Text('High Score: 75',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.grey)),
                ],
              ),
              Container(
                height: 200,
                width: 200,
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
