import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ysty_style_words/constants.dart';
import 'package:ysty_style_words/model/word_model.dart';
import 'package:ysty_style_words/widgets/appbar_secondary.dart';
import 'package:ysty_style_words/widgets/button_rounded.dart';
import '../word_lists/flashcard_content.dart';

class MatchingGamePage extends StatefulWidget {
  const MatchingGamePage({
    super.key,
    required this.category,
    required this.highScore,
    required this.language,
  });

  final String category;
  final int highScore;
  final String language;

  @override
  State<MatchingGamePage> createState() => _FlashcardsPageState();
}

class _FlashcardsPageState extends State<MatchingGamePage> {
  final int _countdownDuration = 120;

  final CountDownController _countdownController = CountDownController();
  List<Word> _current5Word =
      []; // The currently shown 5 word (left side)         if size < 5 -> get 1st element from _next5Word (and remove ir from that list)
  List<Word> _current5Meaning =
      []; // The currently shown 5 meaning (right side)     if size < 5 -> get 1st element from _next5Word (and remove ir from that list)
  List<Word> _next3Word =
      []; // The upcoming 3 shuffled word (left side)       if empty -> refill with the next 3 word from wordsInCategory (and allWordsIndex++)
  List<Word> _next3Meaning =
      []; // The upcoming 3 shuffled meaning (right side)   if empty -> refill with the next 3 meaning from wordsInCategory (and remove ir from that list)
  List<Word> allWords = []; // Contains all the WordModels and shuffled
  bool _isResultsPageOn = false;
  int selectedIndexWord = -1;
  int selectedIndexMeaning = -1;
  int allWordsIndex = 0;
  List<int> _streaks =
      []; // Find the max value from this list, Add new counter value starts from 0 after each streak break. After each correct answer increase last score value
  Color _feedbackButtonColor =
      Colors.black; // black is the base selecting color
  int _mistakeCounter = 0; // mistake counter +1 fo   r each wrong answer
  int _matchCounter = 0; // founded good matches (answers)
  int _delayedWordIndex = -1;
  int _delayedMeaningIndex = -1;

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

    checkNext3();
    // _loadNext5Word();
  }

  checkNext3() {
    /// Check the user already went through all the words, if true reshuffle list and reset index counter
    if (allWords.length == allWordsIndex + 1) {
      allWords.shuffle();
      allWordsIndex = 0;
    }

    /// Check _next5Words and _next5Meaning size in case they need a refill
    while (_next3Word.length < 3 && _next3Meaning.length < 3) {
      _next3Word.add(allWords[allWordsIndex]);
      _next3Meaning.add(allWords[allWordsIndex]);
      allWordsIndex++;
    }

    /// Shuffle the next5Words & next5Meaning words
    _next3Word.shuffle();
    _next3Meaning.shuffle();
  }

  checkAnswer({required Word selectedWord, required Word selectedMeaning}) {
    setState(() {
      // if (selectedWord.wordId == selectedMeaning.wordId) {
      if (widget.language == "english" ? (selectedWord.englishMeaning == selectedMeaning.englishMeaning) : (selectedWord.hungarianMeaning == selectedMeaning.hungarianMeaning))  {
        // Correct answer ======================================================

        /// Remove correct words from current list and replace them by index with next3Word/Meaning
        _current5Word[selectedIndexWord] = _next3Word[0];
        _current5Meaning[selectedIndexMeaning] = _next3Meaning[0];

        /// Remove first elements from _next3Word and _next3Meaning after it has been added to current lists
        _next3Word.removeAt(0);
        _next3Meaning.removeAt(0);

        /// Refill _next3 lists with a new word
        checkNext3();

        /// TODO: Add delay effect for replaced cards before the previous selected indexes resets
        delayNextCards();

        /// Reset selected indexes
        selectedIndexWord = -1;
        selectedIndexMeaning = -1;

        /// Increase score
        _matchCounter++;

        /// Increase streak counter
        if (_streaks.isEmpty) {
          _streaks.add(1);
        } else {
          _streaks[_streaks.length - 1] += 1;
        }

        /// Reset feedbackButtonColor to black
        _feedbackButtonColor = Colors.black;
      } else {
        // Wrong answer ========================================================
        _feedbackButtonColor = Colors.red;

        /// TODO: Maybe reduce remaining time duration "-5 seconds" or calculate mistakes 2x for scores
        /// Increase mistake counter
        _mistakeCounter++;

        ///Add streak counter value to _streaks and start new counting from 0
        _streaks.add(0);
      }
    });
  }

  delayNextCards() async {
    /// get selected correct card indexes
    _delayedWordIndex = selectedIndexWord;
    _delayedMeaningIndex = selectedIndexMeaning;

    /// TODO: delay 1 o 2 sec
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      /// reset to base value
      _delayedWordIndex = -1;
      _delayedMeaningIndex = -1;
    });
  }

  Future<void> _saveHighScore(int newHighScore) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('highScore', newHighScore);
  }

  @override
  Widget build(BuildContext context) {
    return _isResultsPageOn ? _showResultsScreen(widget.language) : _showGameScreen();
  }

  /// ResultsScreen ============================================================
  Widget _showResultsScreen(String language) {
    if ((_matchCounter - _mistakeCounter) > widget.highScore) {
      _saveHighScore(_matchCounter - _mistakeCounter);
    }
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
                    onPressed: () => Navigator.pop(context), title: matching_game_page_result_appbartitle[widget.language]!),
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
                      Text(matching_game_page_result_title[language]!,
                          style: TextStyle(
                              fontSize: 38.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      Text(matching_game_page_result_subtitle[language]!,
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
                          text: 'High Score',
                          iconData: FontAwesomeIcons.medal,
                          numberValue: (_matchCounter - _mistakeCounter) >
                                  widget.highScore
                              ? (_matchCounter - _mistakeCounter)
                              : widget.highScore),
                      _resultsCard(
                        text: 'Current Score',
                        iconData: FontAwesomeIcons.solidStar,
                        numberValue: (_matchCounter - _mistakeCounter),

                        /// TODO: decrease reaming time duration or count mistakes 2x for score calculations
                        // numberValue: (_matchCounter - (_mistakeCounter * 2)),
                      ),
                      _resultsCard(
                        text: 'Longest streak',
                        iconData: FontAwesomeIcons.fire,
                        numberValue: _streaks.isEmpty
                            ? _matchCounter
                            : (_streaks).reduce((a, b) => a > b ? a : b),
                        // .sort(),
                        // .reduce(combine)
                        // .sortReversed()[0],
                        // numberValue: _matchCounter,
                      ),
                      _resultsCard(
                          text: 'Mistakes',
                          iconData: FontAwesomeIcons.triangleExclamation,
                          numberValue: _mistakeCounter),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ButtonRounded(

                      ///TODO: Call refresh for the MatchingPage --> widget.onRefresh(); for refreshing the highScore over there
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

  Widget _resultsCard(
      {required IconData iconData,
      required String text,
      required int numberValue}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(10),
          // border: Border.all(color: Colors.black45, width: 2)),
          border: Border.all(color: Colors.grey.shade200, width: 3)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            flex: 3,
            child: Text(
              text,
              style: const TextStyle(
                  // fontWeight: FontWeight.w800,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.black45),
              // color: Colors.grey.shade500),
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  iconData,
                  color: Colors.black,
                  size: 20.0,
                ),
                const SizedBox(width: 20.0),
                Text(
                  '$numberValue',
                  style: const TextStyle(
                      // fontWeight: FontWeight.w800,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: Colors.black45),
                  // color: Colors.grey.shade500),
                ),
              ],
            ),
          ),
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
    return (isLeftSide && _delayedWordIndex == index) ||
            (!isLeftSide && _delayedMeaningIndex == index)
        ? Container(
            height: 70.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: Colors.green.shade50, width: 3),
                // border: Border.all(color: Colors.grey.shade50, width: 3),
                color: Colors.green.shade50),
            // color: Colors.grey.shade50),
            margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 6.0),
            child: const Center(
                child: Icon(FontAwesomeIcons.check, color: Colors.green)))
        : GestureDetector(
            onTap: () {
              setState(() {
                /// Remove selection if feedback shows previous wrong answer
                if (_feedbackButtonColor == Colors.red) {
                  _feedbackButtonColor = Colors.black;
                  selectedIndexWord = -1;
                  selectedIndexMeaning = -1;
                }

                /// Select button by index
                if (isLeftSide) {
                  selectedIndexWord = index;
                } else {
                  selectedIndexMeaning = index;
                }

                /// If both side has a selected button call chackAnswer
                if (selectedIndexWord != -1 && selectedIndexMeaning != -1) {
                  checkAnswer(
                      selectedWord: _current5Word[selectedIndexWord],
                      selectedMeaning: _current5Meaning[selectedIndexMeaning]);
                }
              });
            },
            child: Container(
              height: 70.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(
                    color: ((isLeftSide && selectedIndexWord == index) ||
                            (!isLeftSide && selectedIndexMeaning == index))
                        ? _feedbackButtonColor
                        : Colors.grey.shade200,
                    width: 3),
                color: ((isLeftSide && selectedIndexWord == index) ||
                        (!isLeftSide && selectedIndexMeaning == index))
                    ? _feedbackButtonColor
                    : Colors.white,
              ),
              margin:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 6.0),
              child: Center(
                  child: Text(
                isLeftSide ? word.germanWord : (widget.language == "english" ? word.englishMeaning : word.hungarianMeaning),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: ((isLeftSide && selectedIndexWord == index) ||
                          (!isLeftSide && selectedIndexMeaning == index))
                      ? Colors.white
                      : Colors.black,
                ),
              )),
            ),
          );
  }
}
