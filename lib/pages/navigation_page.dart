import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ysty_style_words/pages/derdiedas_page.dart';
import 'package:ysty_style_words/pages/flashcards_page.dart';
import 'package:ysty_style_words/pages/matching_page.dart';
import '../widgets/button_navigation.dart';

enum NavigationStatus { flashcardsNav, matchingNav, derdiedasNav }

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  NavigationStatus _navigationStatus = NavigationStatus.flashcardsNav;

  /// TODO: 1. load the category here when the user opens the app and pass it to gamePage
  /// TODO: 2. check sharedPref in each gamePage (FlashcardsPage, MatchingPage, DerDieDasPage)
  /// TODO:     if it's not the same as the one navigationPage passed call voidcallback to update it in navPage
  /// TODO: 3. after a categoryPage redirect send a voidcallback to gamePage to check again   


  void switchNav(NavigationStatus newNavStatus) {
    setState(() {
      _navigationStatus = newNavStatus;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Scaffold(
        // backgroundColor: Colors.grey.shade100,
        // backgroundColor: Colors.black,
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.only(bottom: 60.0),
                child: Column(
                  children: [
                    Expanded(child: _showNavPage()),
                  ],
                ))),
        // child: Expanded(child: _showNavPage()))),
        bottomSheet: Container(
            color: Colors.grey.shade100,
            // color: Colors.grey.shade200,
            height: 62.0,
            child: Column(
              children: [
                Container(color: Colors.grey.shade200, height: 2.0),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ButtonNavigation(
                        isActive:
                            _navigationStatus == NavigationStatus.flashcardsNav,
                        onPressed: () => switchNav(NavigationStatus.flashcardsNav),
                        iconData: FontAwesomeIcons.house,
                      ),
                      ButtonNavigation(
                        isActive: _navigationStatus == NavigationStatus.matchingNav,
                        onPressed: () => switchNav(NavigationStatus.matchingNav),
                        iconData: FontAwesomeIcons.hourglassHalf,
                      ),
                      ButtonNavigation(
                        isActive:
                            _navigationStatus == NavigationStatus.derdiedasNav,
                        onPressed: () => switchNav(NavigationStatus.derdiedasNav),
                        iconData: FontAwesomeIcons.language,
                      ),
                    ]),
              ],
            )));
  }

  _showNavPage() {
    switch (_navigationStatus) {
      case NavigationStatus.flashcardsNav:
        return const FlashcardsPage();
      case NavigationStatus.matchingNav:
        return const MatchingPage();
      case NavigationStatus.derdiedasNav:
        return const DerDieDasPage();
      default:
        return const FlashcardsPage();
    }
  }
}
