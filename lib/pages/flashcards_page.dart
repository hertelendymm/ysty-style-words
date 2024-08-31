import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ysty_style_words/model/word_model.dart';
import 'package:ysty_style_words/services/category_services.dart';
import 'package:ysty_style_words/word_lists/flashcard_content.dart';

class FlashcardsPage extends StatefulWidget {
  const FlashcardsPage({super.key, required this.selectedCategory});

  final String selectedCategory;

  @override
  State<FlashcardsPage> createState() => _FlashcardsPageState();
}

class _FlashcardsPageState extends State<FlashcardsPage> {
  List<Word> wordData = [];

  // int wordIndex = 0;
  bool isCorrectAnswerFound = false;
  String? _selectedCategory;
  final CardSwiperController controller = CardSwiperController();
  // bool isCardFlipped = false;
  ValueNotifier<bool> _isCardFlippedNotifier = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    // isCardFlipped = false;
    _isCardFlippedNotifier = ValueNotifier<bool>(false);
    _selectedCategory = widget.selectedCategory;
    _loadNewGameData();
    // _checkCategory();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  _checkCategory() async {
    String? categoryName = await CategoryService.loadSelectedCategory();
    if (categoryName != _selectedCategory) {
      _selectedCategory = categoryName;
      await _loadNewGameData();
    }
  }

  _loadNewGameData() {
    setState(() {
      wordData = [];
      for (var n in flashcardContents[_selectedCategory!.toLowerCase()]!) {
        Word newWord = Word.fromJson(n);
        wordData.add(newWord);
      }
      wordData.shuffle();
      // wordIndex = 0;
    });
  }


  bool _onSwipe(
    int previousIndex,
    int? currentIndex,
    CardSwiperDirection direction,
  ) {
    print(
        'The card $previousIndex was swiped to the ${direction.name}. Now the card $currentIndex is on top');
    _checkCategory();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // SizedBox(height: 20),
              Flexible(
                child: CardSwiper(
                  cardsCount: wordData.length,
                  onSwipe: _onSwipe,
                  allowedSwipeDirection:
                      const AllowedSwipeDirection.only(left: true, right: true),
                  numberOfCardsDisplayed: 3,
                  padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20.0),
                  controller: controller,
                  backCardOffset: Offset(0, 35),
                  cardBuilder: (
                    context,
                    index,
                    horizontalThresholdPercentage,
                    verticalThresholdPercentage,
                  ) =>Flashcard(
                    index: index,
                    word: wordData[index],
                    isCardFlippedNotifier: _isCardFlippedNotifier,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Tap to flip',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Colors.grey.shade300),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Icon(FontAwesomeIcons.xmark,
                      color: Colors.red, size: 40.0),
                  Icon(FontAwesomeIcons.arrowLeftLong,
                      color: Colors.grey.shade300, size: 40.0),
                  const Text("Swipe",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Colors.grey)),
                  Icon(FontAwesomeIcons.arrowRightLong,
                      color: Colors.grey.shade300, size: 40.0),
                  const Icon(FontAwesomeIcons.check,
                      color: Colors.green, size: 40.0),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Flashcard extends StatelessWidget {
  const Flashcard({super.key,
    required this.index,
    required this.word,
    required this.isCardFlippedNotifier,
  });

  final int index;
  final Word word;
  final ValueNotifier<bool> isCardFlippedNotifier;

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
                border: Border.all(color: isCardFlipped ? Colors.grey.shade300 : Colors.grey.shade900, width: 3,),
                color: isCardFlipped ? Colors.white : Colors.black,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 Text(word.article,
                      style: const TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 20.0,
                          color: Colors.white)),
                  const SizedBox(height: 40.0),
                  Text(isCardFlipped ? word.englishMeaning : word.germanWord,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize:
                              word.germanWord.length > 8 ? 30.0 : 50.0,
                          color: isCardFlipped ? Colors.black : Colors.white)),
                  const SizedBox(height: 40.0),
                  Text(word.exampleSentence,
                    style: const TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 20.0,
                        color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                  // isCardFlipped ? const SizedBox(height: 10.0,): const SizedBox(),
                ],
              ),
            ),

        );
      },
    );
  }
}