import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:ysty_style_words/widgets/appbar_secondary.dart';
import 'package:ysty_style_words/widgets/button_rounded.dart';

import '../word_lists/flashcard_content.dart';

class MatchingGamePage extends StatefulWidget {
  const MatchingGamePage({super.key, required this.category});

  final String category;

  @override
  State<MatchingGamePage> createState() => _FlashcardsPageState();
}

class _FlashcardsPageState extends State<MatchingGamePage> {
  final int _countdownDuration = 120;

  ///120
  final CountDownController _countdownController = CountDownController();
  List _current5Word = [];
  List _current5Meaning = [];
  List _next5Word = [];
  List _next5Meaning = [];
  bool _isResultsPageOn = false;
  List _matchStreaks = [];

  /// Find longest for an current(the last one) from this list

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadNext5Word();
  }

  _loadNext5Word() {
    for (int i = 0; i < 5; i++) {
      _next5Word.add(
          flashcardContents[widget.category.toLowerCase()]![i]["germanWord"]);
      _next5Meaning.add(flashcardContents[widget.category.toLowerCase()]![i]
          ["englishMeaning"]);

      /// TODO: Use the chosen language
    }
    _next5Word.shuffle();
    _next5Meaning.shuffle();
    print(_next5Word);
    print(_next5Meaning);

    // print("${flashcardContents[widget.category.toLowerCase()][0]}");
  }

  @override
  Widget build(BuildContext context) {
    return _isResultsPageOn ? _showResultsScreen() : _showGameScreen();
  }

  /// ResultsScreen ============================================================
  Widget _showResultsScreen() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Container(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppBarSecondary(
                    onPressed: () => Navigator.pop(context), title: 'Results'),
                // const Row(
                //   children: [
                //     Icon(FontAwesomeIcons.xmark, size: 40, color: Colors.white),
                //   ],
                // ),
                Container(
                  width: MediaQuery.sizeOf(context).width * 0.4,
                  height: MediaQuery.sizeOf(context).width * 0.4,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(2000),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Good job!',
                          style: TextStyle(
                              fontSize: 38.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      Text('Keep up the good work',
                          style: TextStyle(
                              fontSize: 28.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      _resultsCard(
                          text: 'High Score: 38',
                          iconData: FontAwesomeIcons.star),
                      _resultsCard(
                          text: 'Current Score: 41',
                          iconData: FontAwesomeIcons.star),
                      _resultsCard(
                          text: 'Longest streak: 17',
                          iconData: FontAwesomeIcons.star),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ButtonRounded(
                      onPressed: () => Navigator.pop(context),
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      text: 'Continue'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// GameScreen ===============================================================
  Widget _showGameScreen() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                AppBarSecondary(
                    onPressed: () => Navigator.pop(context),
                    title: "Time Trial: ${widget.category}")
              ],
            ),
            _showCountdown(),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text('Race against the clock to match the words',
                  style:
                      TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              // padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 1,
                    child: Column(
                      children: [
                        _gameCard(_next5Word[0]),
                        _gameCard(_next5Word[1]),
                        _gameCard(_next5Word[2]),
                        _gameCard(_next5Word[3]),
                        _gameCard(_next5Word[4]),
                      ],
                    ),
                  ),
                  // const SizedBox(width: 30.0),
                  Flexible(
                    flex: 1,
                    child: Column(
                      children: [
                        _gameCard(_next5Meaning[0]),
                        _gameCard(_next5Meaning[1]),
                        _gameCard(_next5Meaning[2]),
                        _gameCard(_next5Meaning[3]),
                        _gameCard(_next5Meaning[4]),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 0),
          ],
        ),
      ),
    );
  }

  /// TODO: Format duration to minutes:seconds
  Widget _showCountdown() {
    return CircularCountDownTimer(
      duration: _countdownDuration,
      initialDuration: 0,
      controller: _countdownController,
      width: MediaQuery.of(context).size.height * 0.05,
      height: MediaQuery.of(context).size.height * 0.05,
      ringColor: Colors.grey.shade200,
      ringGradient: null,
      fillColor: Colors.black,
      fillGradient: null,
      backgroundColor: Colors.white,
      backgroundGradient: null,
      strokeWidth: 12.0,
      strokeCap: StrokeCap.butt,
      // strokeCap: StrokeCap.round,
      textStyle: TextStyle(
          fontSize: MediaQuery.of(context).size.height * 0.02,
          // fontSize: MediaQuery.of(context).size.height * 0.03,
          color: Colors.black,
          fontWeight: FontWeight.bold),
      // fontSize: 24.0, color: Colors.white, fontWeight: FontWeight.bold),
      textFormat: CountdownTextFormat.S,
      isReverse: true,
      isReverseAnimation: true,
      isTimerTextShown: true,
      autoStart: true,
      onStart: () {
        print('Countdown Started');
      },
      onComplete: () {
        print('Countdown Ended');
        setState(() {
          _isResultsPageOn = true;
        });
      },
    );
  }

  Widget _gameCard(String text) {
    return Container(
      height: 70.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.grey.shade200, width: 3),
        color: Colors.white,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 6.0),
      child: Center(
          child: Text(
        text,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      )),
    );
  }

  Widget _resultsCard({required IconData iconData, required String text}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300, width: 3)),
      child: Row(
        children: [
          Icon(iconData, color: Colors.grey.shade700),
          const SizedBox(width: 20.0),
          Text(
            text,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22.0,
                color: Colors.grey.shade700),
          )
        ],
      ),
    );
  }
}
