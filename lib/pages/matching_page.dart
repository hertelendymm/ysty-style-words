import 'package:flutter/material.dart';
import 'package:ysty_style_words/services/category_services.dart';
import 'package:ysty_style_words/widgets/button_rounded.dart';
import 'package:ysty_style_words/widgets/main_app_bar.dart';

import 'matching_game_page.dart';

class MatchingPage extends StatefulWidget {
  const MatchingPage({super.key});
  // const MatchingPage({super.key, required this.selectedCategory});


  @override
  State<MatchingPage> createState() => _MatchingPageState();
}

class _MatchingPageState extends State<MatchingPage> {
  String? _selectedCategory;
  bool _isLoading = true;

  // getSelectedCategory(){
  //   CategoryService.loadSelectedCategory().then((categoryName) {
  //     if (categoryName != null) {
  //       setState(() {
  //         _selectedCategory = categoryName;
  //         debugPrint(_selectedCategory);
  //       });
  //     }
  //   });
  // }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshPage();
  }

  void _refreshPage() {
    setState(() {
      debugPrint("refresh DerDieDas page =================================");
      // _checkCategory();
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
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text('Time Trial',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40.0), textAlign: TextAlign.center,),
                  SizedBox(height: 20.0),
                  Text('How many matches can you make in two minutes? Let\'s find out!',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0), textAlign: TextAlign.center,),
                  SizedBox(height: 20.0),
                  Text('High Score: 75',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.grey)),
                ],
              ),
            ),
            Container(
              height: 200,
              width: 200,
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(250.0), // Half the height for a circular shape
                color: Colors.grey,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ButtonRounded(text: "Start Game", onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context) => const MatchingGamePage()))),
            ),
          ],
        ),
      ),
    );
  }
}
