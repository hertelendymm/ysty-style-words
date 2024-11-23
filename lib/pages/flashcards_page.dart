import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_storage/get_storage.dart';
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
  final box = GetStorage();
  List<String> knownWordIDs = [];
  bool isDisplayCards = true;

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

  List<String> getKnownWordIDs(){
    // List<String>? myList = box.read('knownWordIDs');
    List<String>? myList = box.read('knownWordIDs')?.cast<String>();
    myList ??= [];

    box.write('my_list', myList);
    return myList;
  }

  _loadNewGameData() {
    setState(() {
      _isLoading = true;

      /// Load knownWords list
      knownWordIDs = getKnownWordIDs();
      print("knownWordIDs: $knownWordIDs");

      /// Load wordData from
      _selectedCategory = widget.category;
      wordData = [];
      List<Word> knownWords = [];
      List<Word> notKnownWords = [];

      /// Separate words in category based on the knownWordIDs list
      for (var n in flashcardContents[widget.category]!) {
        // for (var n in flashcardContents[_selectedCategory!.toLowerCase()]!) {
        Word newWord = Word.fromJson(n);
        if(knownWordIDs.contains(newWord.wordId)){
          knownWords.add(newWord);
        }else{
          notKnownWords.add(newWord);
        }
        // wordData.add(newWord);
      }
      /// Shuffle lists so the user will get different card
      knownWords.shuffle();
      notKnownWords.shuffle();
      print("knownWords: $knownWords");
      print("notKnownWords: $notKnownWords");

      /// If notKnownWords >= 6 load 6 notKnownWords into wordData
      if(notKnownWords.length >= 6){
        for(int i=0; i < 6; i++){
          wordData.add(notKnownWords[i]);
        }
      }
      /// If notKnownWords < 6 use knownWords to fill the 6 card places
      else {
        for(var n in notKnownWords){
          wordData.add(n);
        }
        int index = 0;
        while(wordData.length < 6){
          wordData.add(knownWords[index]);
          index++;
        }
      }

      /// Shuffle known and not known words in wordData
      wordData.shuffle();
      print("wordData: $wordData");

      /// Show cards instead of end of deck ads
      isDisplayCards = true;
      _isLoading = false; // Update loading state after data is loaded
    });
  }

  bool _onSwipe(
    int previousIndex,
    int? currentIndex,
    CardSwiperDirection direction,
  ) {
    if (direction.name == "right") {
      /// Add to DB if not in knowWordIDs
      if(!knownWordIDs.contains(wordData[previousIndex].wordId)) {
        addItemToGetStorage(wordData[previousIndex].wordId);
      }
    } else {
      /// Remove from DB if in knowWords
      if(knownWordIDs.contains(wordData[previousIndex].wordId)) {
        removeItemFromGetStorage(wordData[previousIndex].wordId);
      }
    }
    print(
        'The card $previousIndex was swiped to the ${direction.name}. Now the card $currentIndex is on top');
    return true;
  }

  void addItemToGetStorage(String wordID) {
    final box = GetStorage();
    List<String>? myList = box.read('knownWordIDs')?.cast<String>();
    myList ??= [];

    myList.add(wordID);
    box.write('knownWordIDs', myList);
  }

  void removeItemFromGetStorage(String itemToRemove) {
    final box = GetStorage();
    List<String>? myList = box.read('knownWordIDs')?.cast<String>();

    if (myList != null) {
      myList.remove(itemToRemove);
      box.write('knownWordIDs', myList);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _isLoading
          ? const CircularProgressIndicator(color: Colors.blue)
          : SafeArea(
              child: isDisplayCards
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _showCards(widget.language),
                        const SizedBox(height: 0),
                        Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text(flashcard_page_flip[widget.language]!,
                                // 'Tap to flip',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                    color: Colors.grey.shade300),
                                textAlign: TextAlign.center)),
                        const SizedBox(height: 20),
                        Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                        const SizedBox(height: 20.0),
                        // const SizedBox(height: 40.0),
                      ],
                    )
                  : Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 0.0),
                          Text(
                            flashcard_page_thank_you[widget.language]!,
                            style: const TextStyle(
                                fontSize: 26.0, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          /// TODO: Show real NativeAds
                          Container(
                            color: Colors.red,
                            width: MediaQuery.sizeOf(context).width,
                            height: MediaQuery.sizeOf(context).width * 0.8,
                            child: const Center(
                              child: Text(
                                'Ad',
                                style: TextStyle(fontSize: 30.0),
                              ),
                            ),
                          ),
                          Text(flashcard_page_ads_text[widget.language]!,
                              style: const TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,),
                          ButtonRounded(
                            onPressed: () => _loadNewGameData(),
                            text: flashcard_page_continue[widget.language]!,
                          ),
                        ],
                      ),
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
            isLoop: false,
            onEnd: () {
              setState(() {
                isDisplayCards = false;
              });
            },
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
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
                            color: isCardFlipped ? Colors.black : Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ],
                    // const SizedBox(height: 40.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                    text: "${word.article} ${word.germanWord}",
                    // text: word.exampleSentence,
                    iconData: FontAwesomeIcons.play,
                    iconColor: isCardFlipped ? Colors.black : Colors.white,
                    title: "Audio",
                    textColor: isCardFlipped ? Colors.black : Colors.white,
                    backgroundColor: isCardFlipped
                        ? Colors.grey.shade100
                        : Colors.white.withOpacity(0.1),
                  ),
                ),
                // Padding(
                //     padding: const EdgeInsets.symmetric(horizontal: 20.0),
                //     child: Text(flashcard_page_flip[language]!,
                //         // 'Tap to flip',
                //         style: TextStyle(
                //             fontWeight: FontWeight.bold,
                //             fontSize: 16.0,
                //             color: Colors.grey),
                //         textAlign: TextAlign.center)),
              ],
            ),
          ),
        );
      },
    );
  }
}
