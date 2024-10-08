import 'package:flutter/material.dart';
import 'package:ysty_style_words/widgets/button_rounded.dart';

import 'matching_game_page.dart';

class MatchingPage extends StatefulWidget {
  const MatchingPage({super.key, required this.category});

  final String category;

  @override
  State<MatchingPage> createState() => _MatchingPageState();
}

class _MatchingPageState extends State<MatchingPage> {
  bool _isLoading = true;
  String? _selectedCategory;

  /// I will need this to to the MatchingGame page

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _loadSelectedCategory();
    _selectedCategory = widget.category;
    print("||||||||||||||||||$_selectedCategory");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        // child: _isLoading ? const LoadingScreen() : Column(
        // child: _isLoading ? const CircularProgressIndicator(color: Colors.white) : Column(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // MainAppBar(updateParent: _loadSelectedCategory, selectedCategory: _selectedCategory.toString()),
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 40, 20, 20.0),
              child: Column(
                children: [
                  Text('Time Trial',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 40.0),
                      textAlign: TextAlign.center),
                  SizedBox(height: 20.0),
                  Text(
                      'How many matches can you make in two minutes? Let\'s find out!',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                      textAlign: TextAlign.center),
                  SizedBox(height: 20.0),
                  Text('High Score: 75',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Colors.grey)),
                ],
              ),
            ),
            Container(
              height: 200,
              width: 200,
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(250.0),
                // Half the height for a circular shape
                color: Colors.grey,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ButtonRounded(
                  text: "Start Game",
                  onPressed: (){
                    _selectedCategory = widget.category;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MatchingGamePage(
                              category: _selectedCategory!,
                            )));
                  },
                  // onPressed: () => Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => MatchingGamePage(
                  //               category: _selectedCategory!,
                  //             ))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
