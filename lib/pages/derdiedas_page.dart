import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ysty_style_words/model/word_model.dart';
import 'package:ysty_style_words/pages/derdiedas_help_page.dart';
import 'package:ysty_style_words/services/category_services.dart';
import 'package:ysty_style_words/widgets/button_rounded.dart';
import 'package:ysty_style_words/widgets/main_app_bar.dart';
import 'package:ysty_style_words/word_lists/flashcard_content.dart';


class DerDieDasPage extends StatefulWidget {
  const DerDieDasPage({super.key});

  @override
  State<DerDieDasPage> createState() => _DerDieDasPageState();
}

class _DerDieDasPageState extends State<DerDieDasPage> {
  List<Word> wordData = [];
  int wordIndex = 0;
  bool isCorrectAnswerFound = false;
  String userAnswer = "";
  String? _selectedCategory;
  bool _isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadSelectedCategory();
  }

  void _refreshPage() {
    setState(() {
      print("refresh DerDieDas page =================================");
      _isLoading = true;
      _loadSelectedCategory();
    });
  }

  Future<void> _loadSelectedCategory() async {
    String? categoryName = await CategoryService.loadSelectedCategory();
    setState(() {
      _selectedCategory = categoryName;
      _isLoading = false; // Update loading state after data is loaded
    });
    await _loadNewGameData();
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
      userAnswer = "";
    });

  }

  Future<Word> _getNextWord() async{
    setState(() {
      wordIndex += 1;
      if (wordIndex >= wordData.length){
        _loadNewGameData();
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
      body: SafeArea(
        child: _isLoading ? const CircularProgressIndicator() : Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MainAppBar(updateParent: _refreshPage, selectedCategory: '',),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: ButtonRounded(text: "Skip", onPressed: ()=>_getNextWord(), backgroundColor: Colors.grey.shade100, textColor: Colors.black, isIconWText: true, iconData: FontAwesomeIcons.shuffle,)),
                  const SizedBox(width: 20.0),
                  Expanded(child: ButtonRounded(text: "Help", onPressed: () =>Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DerDieDasHelpPage())), backgroundColor: Colors.grey.shade100, textColor: Colors.black, isIconWText: true, iconData: FontAwesomeIcons.lightbulb,)),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
              margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
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
                  const Text('------',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 40.0)),
                  Text(wordData[wordIndex].germanWord,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 40.0)),
                ],
              ),
            ),
            isCorrectAnswerFound ?
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ButtonRounded(text: "Next", backgroundColor: Colors.black, textColor: Colors.white, onPressed: ()=>_getNextWord()),
            ):
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
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
            ),
            const SizedBox(),
          ],
        ),
      ),
    );
  }
}
