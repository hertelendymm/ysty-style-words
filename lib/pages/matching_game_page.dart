import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

class MatchingGamePage extends StatefulWidget {
  const MatchingGamePage({super.key});

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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(FontAwesomeIcons.xmark)),
            const SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: GestureDetector(
                // onTap: () => Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => const CategoriesPage())),
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
            Text("10XP"), //Score counter
          ],
        ),
        // centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
            )
          ],
        ),
      ),
    );
  }

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

  Widget _gameCard(){
    return Container(
        width: 160.0,
        height: 80.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: Colors.grey, width: 3),
          color: Colors.white,
        ),
        margin: const EdgeInsets.all(10.0));
  }


}
