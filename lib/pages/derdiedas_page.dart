import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ysty_style_words/model/word_model.dart';
import 'package:ysty_style_words/pages/derdiedas_help_page.dart';
import 'package:ysty_style_words/services/category_services.dart';
import 'package:ysty_style_words/widgets/button_rounded.dart';
import 'package:ysty_style_words/word_lists/flashcard_content.dart';
import 'dart:convert';


class DerDieDasPage extends StatefulWidget {
  // const DerDieDasPage({super.key});
  const DerDieDasPage({super.key, required this.selectedCategory});

  final String selectedCategory;

  @override
  State<DerDieDasPage> createState() => _DerDieDasPageState();
}

class _DerDieDasPageState extends State<DerDieDasPage> {

  List<Word> wordData = [];
  int wordIndex = 0;
  bool isCorrectAnswerFound = false;
  String userAnswer = "";

  String? _selectedCategory;

  // String? _selectedCategory;
  // String _selectedCategory = 'Select a category';

  // getSelectedCategory() async {
  //   String? selectedCategory = await CategoryService.loadSelectedCategory();
  //   if (selectedCategory != null) {
  //     setState(() {
  //       _selectedCategory = _selectedCategory;
  //     });
  //   }
  // }


  // getSelectedCategory(){
  //   CategoryService.loadSelectedCategory().then((categoryName) {
  //     if (categoryName != null) {
  //       // Use the categoryName to load relevant content
  //       setState(() {
  //         _selectedCategory = categoryName;
  //       });
  //     }
  //   });
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getSelectedCategory();
    print("derdiedas init");
    _selectedCategory = widget.selectedCategory;
    _loadGameData();
  }

  _checkCategory() async {
    print("_checkCategory");
    String? categoryName = await CategoryService.loadSelectedCategory();
    print("current category===$_selectedCategory}");
    print("categoryName===$categoryName}");
    if (categoryName != _selectedCategory) {
      // setState(() async {
        print("_checkCategory change found");
        _selectedCategory = categoryName;
        await _loadGameData();
        print("_checkCategory changed category");
      // });
    }
  }

  _loadGameData(){
    setState(() {
      print("DerDieDasPage: ${_selectedCategory}");

      wordData = [];
      for(var n in flashcardContents[_selectedCategory!.toLowerCase()]!){
        Word newWord = Word(
          wordId: n["wordId"] ?? '',
          germanWord: n["germanWord"] ?? '',
          englishMeaning: n["englishMeaning"] ?? '',
          exampleSentence: n["exampleSentence"] ?? '',
          article: n["article"] ?? '',
          category: n["category"] ?? '',
        );
        // print(newWord.toString());
        wordData.add(newWord);
      }
      // print(wordData);
      wordData.shuffle();
      wordIndex = 0;
      userAnswer = "";
      // print(wordData);
    });

  }

  Future<Word> _getNextWord()async{

    print("_checkCategory before call");
    await _checkCategory();
    print("_checkCategory after call");
    setState(() {
      wordIndex += 1;
      if (wordIndex >= wordData.length){
        _loadGameData();
        wordIndex = 0;
      }
      isCorrectAnswerFound = false;
      userAnswer = "";
    });
    return wordData[wordIndex];
  }

  _checkAnswer(String answer){
    setState(() {
      userAnswer = answer;
      isCorrectAnswerFound = userAnswer == wordData[wordIndex].article;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: MainAppBar(),
      // appBar: MainAppBar(selectedCategory: _selectedCategory),
      // appBar: const MainAppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // ButtonRounded(text: "Help", backgroundColor: Colors.grey.shade200, textColor: Colors.black, onPressed: ()=>Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => const DerDieDasHelpPage()))),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: ButtonRounded(text: "Skip", onPressed: ()=>_getNextWord(), backgroundColor: Colors.grey.shade100, textColor: Colors.black, isIconWText: true, iconData: FontAwesomeIcons.shuffle,)),
                  const SizedBox(width: 20.0),
                  Expanded(child: ButtonRounded(text: "Help", onPressed: () =>Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DerDieDasHelpPage())), backgroundColor: Colors.grey.shade100, textColor: Colors.black, isIconWText: true, iconData: FontAwesomeIcons.lightbulb,)),
                  // const SizedBox(width: 20.0),
                  // Expanded(child: ButtonRounded(text: "Next", onPressed: () {}, backgroundColor: Colors.white, textColor: Colors.black, isIconWText: true, iconData: FontAwesomeIcons.forwardStep,)),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
                margin: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(color: Colors.grey.shade300, width: 3),
                    color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(userAnswer,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 40.0, color: isCorrectAnswerFound? Colors.green:Colors.red)),
                    Text('------',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 40.0)),
                    // Text('________',
                    //     style: TextStyle(
                    //         fontWeight: FontWeight.bold, fontSize: 40.0)),
                    // Text('Krankenwagen',
                    Text(wordData[wordIndex].germanWord,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 40.0)),
                  ],
                ),
              ),
              isCorrectAnswerFound ?
              ButtonRounded(text: "Next", backgroundColor: Colors.black, textColor: Colors.white, onPressed: ()=>_getNextWord()):
              Row(
                children: [
                  Expanded(
                      child: ButtonRounded(
                    text: "der",
                    onPressed: ()=>_checkAnswer("der")
                  )),
                  const SizedBox(width: 20.0),
                  Expanded(child: ButtonRounded(text: "die", onPressed: ()=>_checkAnswer("die"))),
                  const SizedBox(width: 20.0),
                  Expanded(child: ButtonRounded(text: "das", onPressed: ()=>_checkAnswer("das"))),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
