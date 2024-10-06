import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

class MatchingGamePage extends StatefulWidget {
  const MatchingGamePage({super.key, required this.category});

  final String category;

  @override
  State<MatchingGamePage> createState() => _FlashcardsPageState();
}

class _FlashcardsPageState extends State<MatchingGamePage> {
  final int _countdownDuration = 120;
  final CountDownController _countdownController = CountDownController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                            padding:
                                const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(
                                  10.0, 10.0, 10.0, 10.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25.0),
                                  color: Colors.grey.shade200),
                              child: const Icon(FontAwesomeIcons.xmark,
                                  color: Colors.black),
                            )),
                      ),
                      // child: const Icon(FontAwesomeIcons.xmark, size: 30.0,)),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40.0),
                              border: Border.all(
                                  color: Colors.grey.shade300, width: 3)),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0.0, vertical: 6.0),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 0.0, vertical: 12.0),
                          child: Center(
                              child: Text(widget.category,
                                  // child: Text(_selectedCategory!,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                  textAlign: TextAlign.center)),
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      const Text("10XP", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
                      //Score counter
                    ],
                  ),
                ),
                Container(color: Colors.grey.shade200, height: 2.0),
              ],
            ),
            _showCountdown(),
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
      width: MediaQuery.of(context).size.height * 0.08,
      height: MediaQuery.of(context).size.height * 0.08,
      // width: 60.0,
      // height: 60.0,
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
          fontSize: MediaQuery.of(context).size.height * 0.03,
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
      },
    );
  }

  Widget _gameCard() {
    return Container(
      width: 160.0,
      height: 80.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.grey.shade200, width: 3),
        color: Colors.white,
      ),
      margin: const EdgeInsets.all(10.0),
    );
  }
}
