import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ysty_style_words/constants.dart';
import 'package:ysty_style_words/widgets/button_rounded.dart';

import 'matching_game_page.dart';

class MatchingPage extends StatefulWidget {
  const MatchingPage(
      {super.key, required this.category, required this.language});

  final String category;
  final String language;

  @override
  State<MatchingPage> createState() => _MatchingPageState();
}

class _MatchingPageState extends State<MatchingPage> {
  bool _isLoading = true;
  String? _selectedCategory;
  int _highScore = 0;

  /// I will need this to to the MatchingGame page

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _loadSelectedCategory();
    _loadHighScore();
    _selectedCategory = widget.category;
    print("||||||||||||||||||$_selectedCategory");
  }

  Future<void> _loadHighScore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _highScore = prefs.getInt('highScore') ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        // child: _isLoading ? const LoadingScreen() : Column(
        // child: _isLoading ? const CircularProgressIndicator(color: Colors.white) : Column(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(),
            Text(matching_page_title[widget.language]!,
                // Text(widget.language,
                // Text(widget.language == "english" ? 'Time Trial' : 'Időpróba',
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 40.0),
                textAlign: TextAlign.center),
            Container(
              // height: 200,
              // width: 200,
              height: MediaQuery.sizeOf(context).width * 0.5,
              width: MediaQuery.sizeOf(context).width * 0.5,
              // padding: const EdgeInsets.all(0.0),
              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.circular(250.0),
                // Half the height for a circular shape
                // color: Colors.grey.shade100,
              // ),
              child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Image.asset('assets/icon/stopwatch.png',
                        width: MediaQuery.sizeOf(context).width * 0.5,
                        height: MediaQuery.sizeOf(context).width * 0.5),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0.0),
              child: Column(
                children: [
                  // Text(matching_page_title[widget.language]!,
                  //     // Text(widget.language,
                  //     // Text(widget.language == "english" ? 'Time Trial' : 'Időpróba',
                  //     style: const TextStyle(
                  //         fontWeight: FontWeight.bold, fontSize: 40.0),
                  //     textAlign: TextAlign.center),
                  // const SizedBox(height: 20.0),
                  Text(matching_page_subtitle[widget.language]!,
                      // 'How many matches can you make in two minutes? Let\'s find out!',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 22.0),
                      textAlign: TextAlign.center),
                  const SizedBox(height: 20.0),
                  Text(
                      '${matching_page_highscore[widget.language]!}: $_highScore',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Colors.grey)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ButtonRounded(
                text: matching_page_start[widget.language]!,
                // text: "Start Game",
                onPressed: () {
                  _selectedCategory = widget.category;
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MatchingGamePage(
                                category: _selectedCategory!,
                                highScore: _highScore,
                                language: widget.language,
                              )));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
