import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ysty_style_words/constants.dart';
import 'package:ysty_style_words/model/word_model.dart';
import 'package:ysty_style_words/widgets/button_rounded.dart';
import 'package:ysty_style_words/widgets/button_tts.dart';
import 'package:ysty_style_words/word_lists/flashcard_content.dart';

class FlashcardsPage extends StatefulWidget {
  const FlashcardsPage(
      {super.key, required this.category, required this.language});

  final String category;
  final String language;

  @override
  State<FlashcardsPage> createState() => _FlashcardsPageState();
}

class _FlashcardsPageState extends State<FlashcardsPage> {
  List<Word> wordData = [];
  bool isCorrectAnswerFound = false;
  final CardSwiperController controller = CardSwiperController();
  ValueNotifier<bool> _isCardFlippedNotifier = ValueNotifier<bool>(false);
  String? _selectedCategory;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.category;
    _isCardFlippedNotifier = ValueNotifier<bool>(false);
    // _loadSelectedCategory();
    print("${widget.category} - $_selectedCategory");
    _loadNewGameData();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  _loadNewGameData() {
    setState(() {
      _selectedCategory = widget.category;
      wordData = [];
      for (var n in flashcardContents[widget.category]!) {
        // for (var n in flashcardContents[_selectedCategory!.toLowerCase()]!) {
        Word newWord = Word.fromJson(n);
        wordData.add(newWord);
      }
      wordData.shuffle();
      // await Future.delayed(Duration(milliseconds: 500));
      _isLoading = false; // Update loading state after data is loaded
    });
  }

  bool _onSwipe(
    int previousIndex,
    int? currentIndex,
    CardSwiperDirection direction,
  ) {
    print(
        'The card $previousIndex was swiped to the ${direction.name}. Now the card $currentIndex is on top');
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: _isLoading
            ? const CircularProgressIndicator(color: Colors.blue)
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _showCards(widget.language),
                  const SizedBox(height: 0),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(flashcard_page_flip[widget.language]!,
                          // 'Tap to flip',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              color: Colors.grey.shade300),
                          textAlign: TextAlign.center)),
                  const SizedBox(height: 40),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Icon(FontAwesomeIcons.xmark,
                                color: Colors.red, size: 40.0),
                            Icon(FontAwesomeIcons.arrowLeftLong,
                                color: Colors.grey.shade300, size: 40.0),
                            Text(flashcard_page_swipe[widget.language]!,
                                // "Swipe",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                    color: Colors.grey)),
                            Icon(FontAwesomeIcons.arrowRightLong,
                                color: Colors.grey.shade300, size: 40.0),
                            const Icon(FontAwesomeIcons.check,
                                color: Colors.green, size: 40.0)
                          ])),
                  const SizedBox(height: 40.0),
                ],
              ),
      ),
    );
  }

  Widget _showCards(String language) {
    if (_selectedCategory != widget.category) {
      _loadNewGameData();
    }
    return Flexible(
        child: CardSwiper(
            cardsCount: wordData.length,
            onSwipe: _onSwipe,
            allowedSwipeDirection:
                const AllowedSwipeDirection.only(left: true, right: true),
            numberOfCardsDisplayed: 3,
            padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40.0),
            controller: controller,
            backCardOffset: const Offset(0, 35),
            cardBuilder: (
              context,
              index,
              horizontalThresholdPercentage,
              verticalThresholdPercentage,
            ) =>
                Flashcard(
                  index: index,
                  word: wordData[index],
                  isCardFlippedNotifier: _isCardFlippedNotifier,
                  language: language,
                )));
  }
}

class Flashcard extends StatelessWidget {
  const Flashcard({
    super.key,
    required this.index,
    required this.word,
    required this.isCardFlippedNotifier,
    required this.language,
  });

  final int index;
  final Word word;
  final ValueNotifier<bool> isCardFlippedNotifier;
  final String language;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isCardFlippedNotifier,
      builder: (context, isCardFlipped, child) {
        return GestureDetector(
          onTap: () {
            isCardFlippedNotifier.value = !isCardFlipped;
          },
          child: Container(
            width: MediaQuery.sizeOf(context).width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(
                color:
                    // isCardFlipped ? Colors.black : Colors.grey.shade900,
                    isCardFlipped ? Colors.grey.shade400 : Colors.grey.shade900,
                // width: 6,
                width: 3,
              ),
              color: isCardFlipped ? Colors.white : Colors.black,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(),
                Column(
                  children: [
                    Text(word.article,
                        style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 20.0,
                            color: Colors.white)),
                    // const SizedBox(height: 40.0),
                    Text(
                        isCardFlipped
                            ? (language == 'english'
                                ? word.englishMeaning
                                : word.hungarianMeaning)
                            : word.germanWord,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: word.germanWord.length > 8 ? 30.0 : 50.0,
                            color:
                                isCardFlipped ? Colors.black : Colors.white)),
                  ],
                  // const SizedBox(height: 40.0),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  // padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    word.exampleSentence,
                    style: const TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 20.0,
                        color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 0.0, horizontal: 40.0),
                  child: ButtonTts(
                    word: word,
                    iconData: FontAwesomeIcons.play,
                    iconColor: Colors.white,
                    text: "Audio",
                    backgroundColor: Colors.white.withOpacity(0.1),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
