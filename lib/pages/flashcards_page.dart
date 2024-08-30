import 'package:flutter/material.dart';
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
  int wordIndex = 0;
  bool isCorrectAnswerFound = false;
  String? _selectedCategory;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedCategory = widget.selectedCategory;
    _loadNewGameData();
    // _checkCategory();
  }

  _checkCategory() async {
    String? categoryName = await CategoryService.loadSelectedCategory();
    if (categoryName != _selectedCategory) {
      _selectedCategory = categoryName;
      await _loadNewGameData();
    }
  }


  _loadNewGameData(){
    setState(() {
      wordData = [];
      for(var n in flashcardContents[_selectedCategory!.toLowerCase()]!){
        Word newWord = Word.fromJson(n);
        wordData.add(newWord);
      }
      wordData.shuffle();
      wordIndex = 0;
    });
  }

  Future<Word> _getNextWord()async{
    await _checkCategory();
    setState(() {
      wordIndex += 1;
      if (wordIndex >= wordData.length){
        _loadNewGameData();
        wordIndex = 0;
      }
      isCorrectAnswerFound = false;
    });
    return wordData[wordIndex];
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
              const SizedBox(height: 0.0),
              Column(
                children: [
                  GestureDetector(
                    onTap: ()=> _getNextWord(),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 100.0),
                      margin: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 20.0),
                      width: MediaQuery.sizeOf(context).width*0.75,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.black),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(wordData[wordIndex].article,
                              style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 20.0, color: Colors.white)),
                          const SizedBox(height: 40.0),
                          Text(wordData[wordIndex].germanWord,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 50.0, color: Colors.white)),
                          const SizedBox(height: 40.0),
                          Text(wordData[wordIndex].exampleSentence,
                              style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 20.0, color: Colors.grey), textAlign: TextAlign.center,),
                        ],
                      ),
                    ),
                  ),
                  Text('Tap to flip',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.grey.shade300), textAlign: TextAlign.center,),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Icon(FontAwesomeIcons.xmark, color: Colors.red, size: 40.0),
                  Icon(FontAwesomeIcons.arrowLeftLong, color: Colors.grey.shade300, size: 40.0),
                  const Text("Swipe",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.grey)),
                  Icon(FontAwesomeIcons.arrowRightLong, color: Colors.grey.shade300, size: 40.0),
                  const Icon(FontAwesomeIcons.check, color: Colors.green, size: 40.0),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
