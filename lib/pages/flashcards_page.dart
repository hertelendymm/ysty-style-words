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

  @override
  void initState() {
    super.initState();
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

  // Future<Word> _getNextWord()async{
  //   await _checkCategory();
  //   setState(() {
  //     // wordIndex += 1;
  //     // if (wordIndex >= wordData.length){
  //     //   _loadNewGameData();
  //     //   // wordIndex = 0;
  //     // }
  //     // isCorrectAnswerFound = false;
  //   });
  //   return wordData[wordIndex];
  // }

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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // SizedBox(height: 0),
              Flexible(
                child: CardSwiper(
                  cardsCount: wordData.length,
                  onSwipe: _onSwipe,
                  allowedSwipeDirection: const AllowedSwipeDirection.only(left: true, right: true),
                  numberOfCardsDisplayed: 3,
                  controller: controller,
                  cardBuilder: (
                    context,
                    index,
                    horizontalThresholdPercentage,
                    verticalThresholdPercentage,
                  ) =>
                      flashcard(index),
                ),
              ),
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

  Widget flashcard(int index) {
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 100.0),
        margin: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 20.0),
        width: MediaQuery.sizeOf(context).width,
        height: 500.0,
        // width: MediaQuery.sizeOf(context).width * 0.75,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0), color: Colors.black),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(wordData[index].article,
                style: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 20.0,
                    color: Colors.white)),
            const SizedBox(height: 40.0),
            Text(wordData[index].germanWord,
                style:  TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: wordData[index].germanWord.length > 8 ? 30.0 : 50.0,
                    color: Colors.white)),
            const SizedBox(height: 40.0),
            Text(
              wordData[index].exampleSentence,
              style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 20.0,
                  color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     body: SafeArea(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Flexible(
//             child: CardSwiper(
//                 controller: controller,
//                 cardsCount: wordData.length,
//                 onSwipe: _onSwipe,
//                 onEnd: _loadNewGameData,
//                 // onUndo: _onUndo,
//                 numberOfCardsDisplayed: 3,
//                 backCardOffset: const Offset(0, 40),
//                 allowedSwipeDirection:
//                     const AllowedSwipeDirection.symmetric(horizontal: true),
//                 padding: const EdgeInsets.all(0.0),
//                 cardBuilder: (
//                   context,
//                   index,
//                   horizontalThresholdPercentage,
//                   verticalThresholdPercentage,
//                 ) =>
//                     GestureDetector(
//                       // onTap: ()=> _getNextWord(),
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 20.0, vertical: 100.0),
//                         margin: const EdgeInsets.symmetric(
//                             horizontal: 0.0, vertical: 20.0),
//                         width: MediaQuery.sizeOf(context).width * 0.75,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(20.0),
//                             color: Colors.black),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(wordData[index].article,
//                                 style: const TextStyle(
//                                     fontWeight: FontWeight.normal,
//                                     fontSize: 20.0,
//                                     color: Colors.white)),
//                             const SizedBox(height: 40.0),
//                             Text(wordData[index].germanWord,
//                                 style: const TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 50.0,
//                                     color: Colors.white)),
//                             const SizedBox(height: 40.0),
//                             Text(
//                               wordData[index].exampleSentence,
//                               style: const TextStyle(
//                                   fontWeight: FontWeight.normal,
//                                   fontSize: 20.0,
//                                   color: Colors.grey),
//                               textAlign: TextAlign.center,
//                             ),
//                           ],
//                         ),
//                       ),
//                     )
//                 // Container(
//                 //   decoration: BoxDecoration(
//                 //     color: Colors.black
//                 //   ),
//                 //     child: Text(wordData[index].germanWord) ),
//                 ),
//           ),
//           Text(
//             'Tap to flip',
//             style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 20.0,
//                 color: Colors.grey.shade300),
//             textAlign: TextAlign.center,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               const Icon(FontAwesomeIcons.xmark,
//                   color: Colors.red, size: 40.0),
//               Icon(FontAwesomeIcons.arrowLeftLong,
//                   color: Colors.grey.shade300, size: 40.0),
//               const Text("Swipe",
//                   style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 20.0,
//                       color: Colors.grey)),
//               Icon(FontAwesomeIcons.arrowRightLong,
//                   color: Colors.grey.shade300, size: 40.0),
//               const Icon(FontAwesomeIcons.check,
//                   color: Colors.green, size: 40.0),
//             ],
//           ),
//         ],
//       ),
//     ),
//   );
// }

// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     backgroundColor: Colors.white,
//     body: SafeArea(
//       child: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             const SizedBox(height: 0.0),
//             Column(
//               children: [
//                 GestureDetector(
//                   onTap: ()=> _getNextWord(),
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 100.0),
//                     margin: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 20.0),
//                     width: MediaQuery.sizeOf(context).width*0.75,
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(20.0),
//                         color: Colors.black),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(wordData[wordIndex].article,
//                             style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 20.0, color: Colors.white)),
//                         const SizedBox(height: 40.0),
//                         Text(wordData[wordIndex].germanWord,
//                             style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 50.0, color: Colors.white)),
//                         const SizedBox(height: 40.0),
//                         Text(wordData[wordIndex].exampleSentence,
//                             style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 20.0, color: Colors.grey), textAlign: TextAlign.center,),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Text('Tap to flip',
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.grey.shade300), textAlign: TextAlign.center,),
//               ],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 const Icon(FontAwesomeIcons.xmark, color: Colors.red, size: 40.0),
//                 Icon(FontAwesomeIcons.arrowLeftLong, color: Colors.grey.shade300, size: 40.0),
//                 const Text("Swipe",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.grey)),
//                 Icon(FontAwesomeIcons.arrowRightLong, color: Colors.grey.shade300, size: 40.0),
//                 const Icon(FontAwesomeIcons.check, color: Colors.green, size: 40.0),
//               ],
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }
}
