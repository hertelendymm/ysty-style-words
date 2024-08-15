import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ysty_style_words/pages/derdiedas_page.dart';
import 'package:ysty_style_words/pages/flashcards_page.dart';
import 'package:ysty_style_words/pages/matching_page.dart';
import 'package:ysty_style_words/widgets/main_app_bar.dart';
import '../widgets/button_navigation.dart';

enum NavigationStatus {
  flashcards_nav,
  matching_nav,
  derdiedas_nav
}

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  NavigationStatus _navigationStatus = NavigationStatus.flashcards_nav;

  void switchNav(NavigationStatus newNavStatus){
    print("before: $_navigationStatus");
    setState(() {
      _navigationStatus = newNavStatus;
    });
    print("after: $_navigationStatus");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const MainAppBar()),
      // appBar: _showAppBar(),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 60.0),
          child: _showNavPage(),
        ),
      ),
      bottomSheet: Container(color: Colors.grey.shade200,
        height: 60.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ButtonNavigation(
              isActive: _navigationStatus == NavigationStatus.flashcards_nav,
              onPressed: () => switchNav(NavigationStatus.flashcards_nav),
            ),
            ButtonNavigation(
              isActive: _navigationStatus == NavigationStatus.matching_nav,
              onPressed: () => switchNav(NavigationStatus.matching_nav),
            ),
            ButtonNavigation(
              isActive: _navigationStatus == NavigationStatus.derdiedas_nav,
              onPressed: () => switchNav(NavigationStatus.derdiedas_nav),
            ),
          ],
        ),),
    );
  }

  // Widget _showAppBar(){
  //   switch (_navigationStatus){
  //     case NavigationStatus.flashcards_nav:
  //       return const MainAppBar(leftIcon: Icon(FontAwesomeIcons.user), onPressedLeftIcon: (){}, rightIcon: Icon(FontAwesomeIcons.gear), onPressedRightIcon: (){});
  //     case NavigationStatus.matching_nav:
  //       return const MatchingPage();
  //     case NavigationStatus.derdiedas_nav:
  //       return const DerDieDasPage();
  //     default:
  //       return const FlashcardsPage();
  //   }
  //
  // }

  Widget _showNavPage(){
    switch (_navigationStatus){
      case NavigationStatus.flashcards_nav:
        return const FlashcardsPage();
      case NavigationStatus.matching_nav:
        return const MatchingPage();
      case NavigationStatus.derdiedas_nav:
        return const DerDieDasPage();
      default:
        return const FlashcardsPage();
    }

  }

}
