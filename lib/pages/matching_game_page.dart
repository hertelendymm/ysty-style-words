import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:ysty_style_words/model/word_model.dart';
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
  // final int _countdownDuration = 120;
  final int _countdownDuration = 920;

  final CountDownController _countdownController = CountDownController();
  List<Word> _current5Word =
      []; // The currently shown 5 word (left side)         if size < 5 -> get 1st element from _next5Word (and remove ir from that list)
  List<Word> _current5Meaning =
      []; // The currently shown 5 meaning (right side)     if size < 5 -> get 1st element from _next5Word (and remove ir from that list)
  List<Word> _next5Word =
      []; // The upcoming 5 shuffled word (left side)       if empty -> refill with the next 5 word from wordsInCategory (and allWordsIndex++)
  List<Word> _next5Meaning =
      []; // The upcoming 5 shuffled meaning (right side)   if empty -> refill with the next 5 meaning from wordsInCategory (and remove ir from that list)
  List<Word> allWords = []; // Contains all the WordModels and shuffled
  bool _isResultsPageOn = false;
  int selectedIndexLeft = -1;
  int selectedIndexRight = -1;
  int allWordsIndex = 0;
  List _streaks =
      []; // Find the max value from this list, Add counter value after each streak break
  Color _feedbackButtonColor =
      Colors.black; // black is the base selecting color

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    /// Setup when the game begins
    if (allWords.isEmpty) {
      /// Loading all the words
      for (var n in flashcardContents[widget.category.toLowerCase()]!) {
        Word newWord = Word.fromJson(n);
        allWords.add(newWord);
      }
      allWords.shuffle();

      /// Loading the currently show words
      for (int i = 0; i < 5; i++) {
        _current5Word.add(allWords[allWordsIndex]);
        _current5Meaning.add(allWords[allWordsIndex]);
        allWordsIndex++;
      }

      /// Shuffle the currently shown words
      _current5Word.shuffle();
      _current5Meaning.shuffle();
    }

    checkNext5();
    // _loadNext5Word();
  }

  checkNext5(){
    /// Check _next5Words and _next5Meaning size in case they need a refill
    while (_next5Word.length < 5 && _next5Meaning.length < 5) {
      _next5Word.add(allWords[allWordsIndex]);
      _next5Meaning.add(allWords[allWordsIndex]);
      allWordsIndex++;
    }
  }

  checkAnswer({required Word selectedWord, required Word selectedMeaning}) {
    setState(() {
      if (selectedWord.wordId == selectedMeaning.wordId) {
        // Correct answer ===============================
        /// TODO: remove correct words from current list and replace them by index
        

        /// TODO remove chosen word from next5 after added to current

        /// TODO: load new word to current list from next5 >> call checkNext5()

        /// Reset selected indexes
        selectedIndexLeft = -1;
        selectedIndexRight = -1;
      } else {
        // Wrong answer =================================
        _feedbackButtonColor = Colors.red;

        /// TODO: Maybe reduce remaining time duration "-5 seconds"
        /// TODO: Add streak counter value to _streaks and start new counting from 0
        /// TODO: Mistake counter++
      }
    });
  }

  _addNewWordToCurrent() {
    /// Get 1st word from the _next5Word list
    /// Get 1st meaning from the _next5Meaning list
  }

  // _loadNext5Word() {
  //   for (int i = 0; i < 5; i++) {
  //     /// TODO: Use the chosen language
  //
  //     // _next5Word.add(
  //         // flashcardContents[widget.category.toLowerCase()]![i]["germanWord"]);
  //     // _next5Meaning.add(flashcardContents[widget.category.toLowerCase()]![i]
  //     //     ["englishMeaning"]);
  //   }
  //   _next5Word.shuffle();
  //   _next5Meaning.shuffle();
  //   print(_next5Word);
  //   print(_next5Meaning);
  // }

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
                Container(
                  width: MediaQuery.sizeOf(context).width * 0.4,
                  height: MediaQuery.sizeOf(context).width * 0.4,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(2000),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Good job!',
                          style: TextStyle(
                              fontSize: 38.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      Text('Keep up the good work',
                          style: TextStyle(
                              fontSize: 26.0,
                              color: Colors.grey.shade500,
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
                          iconData: FontAwesomeIcons.medal),
                      _resultsCard(
                          text: 'Current Score: 41',
                          iconData: FontAwesomeIcons.solidStar),
                      _resultsCard(
                          text: 'Longest streak: 17',
                          iconData: FontAwesomeIcons.fire),
                      _resultsCard(
                          text: 'Mistakes: 1',
                          iconData: FontAwesomeIcons.triangleExclamation),
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

  Widget _resultsCard({required IconData iconData, required String text}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(10),
          // border: Border.all(color: Colors.black45, width: 2)),
          border: Border.all(color: Colors.grey.shade200, width: 3)),
      child: Row(
        children: [
          Icon(
            iconData,
            color: Colors.black,
            size: 20.0,
          ),
          const SizedBox(width: 20.0),
          Text(
            text,
            style: TextStyle(
                // fontWeight: FontWeight.w800,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: Colors.black45),
            // color: Colors.grey.shade500),
          )
        ],
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 1,
                  child: Column(
                    children: [
                      _gameCard(
                          word: _current5Word[0], isLeftSide: true, index: 0),
                      _gameCard(
                          word: _current5Word[1], isLeftSide: true, index: 1),
                      _gameCard(
                          word: _current5Word[2], isLeftSide: true, index: 2),
                      _gameCard(
                          word: _current5Word[3], isLeftSide: true, index: 3),
                      _gameCard(
                          word: _current5Word[4], isLeftSide: true, index: 4),
                    ],
                  ),
                ),
                // const SizedBox(width: 30.0),
                Flexible(
                  flex: 1,
                  child: Column(
                    children: [
                      _gameCard(
                          word: _current5Meaning[0],
                          isLeftSide: false,
                          index: 0),
                      _gameCard(
                          word: _current5Meaning[1],
                          isLeftSide: false,
                          index: 1),
                      _gameCard(
                          word: _current5Meaning[2],
                          isLeftSide: false,
                          index: 2),
                      _gameCard(
                          word: _current5Meaning[3],
                          isLeftSide: false,
                          index: 3),
                      _gameCard(
                          word: _current5Meaning[4],
                          isLeftSide: false,
                          index: 4),
                    ],
                  ),
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
      width: 80.0,
      height: 80.0,
      // width: MediaQuery.of(context).size.height * 0.05,
      // height: MediaQuery.of(context).size.height * 0.05,
      ringColor: Colors.grey.shade200,
      ringGradient: null,
      fillColor: Colors.black,
      fillGradient: null,
      backgroundColor: Colors.white,
      backgroundGradient: null,
      strokeWidth: 12.0,
      strokeCap: StrokeCap.butt,
      // strokeCap: StrokeCap.round,
      textStyle: const TextStyle(
          fontSize: 18,
          // fontSize: MediaQuery.of(context).size.height * 0.02,
          // fontSize: MediaQuery.of(context).size.height * 0.03,
          color: Colors.black,
          fontWeight: FontWeight.bold),
      // fontSize: 24.0, color: Colors.white, fontWeight: FontWeight.bold),
      textFormat: CountdownTextFormat.MM_SS,
      // textFormat: CountdownTextFormat.MM_SS,
      // textFormat: CountdownTextFormat.S,
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

  Widget _gameCard(
      {required Word word, required bool isLeftSide, required int index}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          /// Remove selection if feedback shows previous wrong answer
          if (_feedbackButtonColor == Colors.red) {
            _feedbackButtonColor = Colors.black;
            selectedIndexLeft = -1;
            selectedIndexRight = -1;
          }

          /// Select button by index
          if (isLeftSide) {
            selectedIndexLeft = index;
          } else {
            selectedIndexRight = index;
          }

          /// If both side has a selected button call chackAnswer
          if (selectedIndexLeft != -1 && selectedIndexRight != -1) {
            checkAnswer(
                selectedWord: _current5Word[selectedIndexLeft],
                selectedMeaning: _current5Meaning[selectedIndexRight]);
          }
        });
      },
      child: Container(
        height: 70.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
              color: ((isLeftSide && selectedIndexLeft == index) ||
                      (!isLeftSide && selectedIndexRight == index))
                  ? _feedbackButtonColor
                  : Colors.grey.shade200,
              width: 3),
          color: ((isLeftSide && selectedIndexLeft == index) ||
                  (!isLeftSide && selectedIndexRight == index))
              ? _feedbackButtonColor
              : Colors.white,
        ),
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 6.0),
        child: Center(
            child: Text(
          isLeftSide ? word.germanWord : word.englishMeaning,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: ((isLeftSide && selectedIndexLeft == index) ||
                    (!isLeftSide && selectedIndexRight == index))
                ? Colors.white
                : Colors.black,
          ),
        )),
      ),
    );
  }
}
