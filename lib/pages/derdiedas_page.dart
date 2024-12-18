import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ysty_style_words/constants.dart';
import 'package:ysty_style_words/model/word_model.dart';
import 'package:ysty_style_words/pages/derdiedas_help_page.dart';
import 'package:ysty_style_words/services/native_ads_helper.dart';
import 'package:ysty_style_words/widgets/button_rounded.dart';
import 'package:ysty_style_words/widgets/button_tts.dart';
import 'package:ysty_style_words/word_lists/flashcard_content.dart';
import 'package:get_storage/get_storage.dart';

class DerDieDasPage extends StatefulWidget {
  const DerDieDasPage(
      {super.key, required this.category, required this.language});

  final String category;
  final String language;

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
  bool _isAdViewUp = false;
  final int _showingAdsFrequencyBetweenCards = 10;
  final NativeAdHelper _adHelper = NativeAdHelper();
  final box = GetStorage();
  List<bool> last100game = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedCategory = widget.category;
    // _selectedCategory = widget.category;
    _loadNewGameData();
    // _loadSelectedCategory();
  }

  @override
  void dispose() {
    _adHelper.dispose();
    super.dispose();
  }

  List<bool> getLast100GameResults(){
    List<bool>? myList = box.read('derDieDasLast100')?.cast<String>();
    myList ??= [];

    box.write('my_list', myList);
    return myList;
  }

  _loadNewGameData() {
    last100game = getLast100GameResults();
    _adHelper.loadAd();
    setState(() {
      _selectedCategory = widget.category;
      wordData = [];
      // for(var n in flashcardContents[_selectedCategory!.toLowerCase()]!){
      for (var n in flashcardContents[widget.category.toLowerCase()]!) {
        Word newWord = Word.fromJson(n);
        wordData.add(newWord);
      }
      wordData.shuffle();
      wordIndex = 0;
      userAnswer = "";
      _isLoading = false;
    });
  }

  _checkForAds() {
    setState(() {
      if ((wordIndex + 1) % _showingAdsFrequencyBetweenCards == 0) {
        _isAdViewUp = true;
      } else {
        _getNextWord();
      }
    });
  }

  Future<Word> _getNextWord() async {
    setState(() {
      wordIndex += 1;
      if (wordIndex >= wordData.length) {
        _loadNewGameData();
        wordIndex = 0;
      }
      isCorrectAnswerFound = false;
      userAnswer = "";
    });
    return wordData[wordIndex];
  }

  _checkAnswer(String answer) {
    setState(() {
      userAnswer = answer;
      isCorrectAnswerFound = userAnswer == wordData[wordIndex].article;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_selectedCategory != widget.category) {
      _loadNewGameData();
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: _isLoading
          ? const CircularProgressIndicator(color: Colors.red)
          : SafeArea(
              child: _isAdViewUp
                  ? _showNativeAdsView()
                  : Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: ["Verbs", "Numbers"].contains(widget.category)
                    ? _showNotAvailableForVerbs(widget.category)
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // MainAppBar(updateParent: _refreshPage, selectedCategory: _selectedCategory.toString()),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 0.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                    child: ButtonRounded(
                                  text: derdiedas_page_skip[widget.language]!,
                                  // text: "Skip",
                                  onPressed: () => _getNextWord(),
                                  backgroundColor: Colors.grey.shade100,
                                  textColor: Colors.black,
                                  isIconWText: true,
                                  iconData: FontAwesomeIcons.shuffle,
                                )),
                                const SizedBox(width: 20.0),
                                Expanded(
                                    child: ButtonRounded(
                                  text: derdiedas_page_help[widget.language]!,
                                  // text: "Help",
                                  onPressed: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DerDieDasHelpPage(
                                                language: widget.language,
                                              ))),
                                  backgroundColor: Colors.grey.shade100,
                                  textColor: Colors.black,
                                  isIconWText: true,
                                  iconData: FontAwesomeIcons.lightbulb,
                                )),
                              ],
                            ),
                          ),
                          _showCard(),
                          isCorrectAnswerFound
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: ButtonRounded(
                                      text:
                                          derdiedas_page_next[widget.language]!,
                                      backgroundColor: Colors.green.shade800,
                                      textColor: Colors.white,
                                      onPressed: () => _checkForAds()),
                                  // onPressed: () => _getNextWord()),
                                )
                              : Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: ButtonRounded(
                                              text: "der",
                                              onPressed: () =>
                                                  _checkAnswer("der"))),
                                      const SizedBox(width: 20.0),
                                      Expanded(
                                          child: ButtonRounded(
                                              text: "die",
                                              onPressed: () =>
                                                  _checkAnswer("die"))),
                                      const SizedBox(width: 20.0),
                                      Expanded(
                                          child: ButtonRounded(
                                              text: "das",
                                              onPressed: () =>
                                                  _checkAnswer("das"))),
                                    ],
                                  ),
                                ),
                          // const SizedBox(),
                        ],
                      ),
              ),
            ),
    );
  }

  Widget _showNativeAdsView() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 0.0),
          Text(
            flashcard_page_thank_you[widget.language]!,
            style: const TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),

          /// TODO: Show real NativeAds
          _adHelper.getAdWidget(),
          Text(
            flashcard_page_ads_text[widget.language]!,
            style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          ButtonRounded(
            onPressed: () {
              setState(() {
                _isAdViewUp = false;
                _getNextWord();
              });
            },
            text: flashcard_page_continue[widget.language]!,
          ),
        ],
      ),
    );
  }

  Widget _showCard() {
    return Container(
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
                  fontWeight: FontWeight.bold,
                  fontSize: 40.0,
                  color: isCorrectAnswerFound ? Colors.green : Colors.red)),
          const Text('------',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40.0)),
          Text(wordData[wordIndex].germanWord,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 40.0)),
          const SizedBox(height: 14.0),
          Text(
              widget.language == 'english'
                  ? wordData[wordIndex].englishMeaning
                  : wordData[wordIndex].hungarianMeaning,
              style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0)),
          const SizedBox(height: 14.0),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 00.0),
            child: ButtonTts(
              text: wordData[wordIndex].germanWord,
              iconData: FontAwesomeIcons.play,
              iconColor: Colors.black,
              title: "Audio",
              textColor: Colors.black,
              backgroundColor: Colors.grey.shade100,
            ),
          ),
        ],
      ),
    );
  }

  Widget _showNotAvailableForVerbs(String category) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0), color: Colors.black),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('Not Available',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40.0,
                      color: Colors.white),
                  textAlign: TextAlign.center),
              const SizedBox(height: 30.0),
              Container(
                  width: MediaQuery.sizeOf(context).width * 0.3,
                  height: 4,
                  color: Colors.white),
              const SizedBox(height: 30.0),
              Text(
                  "This feature is not available for the '$category' category, as words in this category typically do not have a gender in German. \n\nPlease choose a different category to use this feature.",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                      color: Colors.white),
                  textAlign: TextAlign.justify)
            ]),
      ),
    );
  }
}
