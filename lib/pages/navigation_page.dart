import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ysty_style_words/pages/categories_page.dart';
import 'package:ysty_style_words/pages/derdiedas_page.dart';
import 'package:ysty_style_words/pages/flashcards_page.dart';
import 'package:ysty_style_words/pages/matching_page.dart';
import 'package:ysty_style_words/pages/settings_page.dart';
import 'package:ysty_style_words/services/category_services.dart';
import '../widgets/button_navigation.dart';

enum NavigationStatus { flashcardsNav, matchingNav, derdiedasNav }

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  NavigationStatus _navigationStatus = NavigationStatus.flashcardsNav;

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
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.only(bottom: 60.0),
                child: Expanded(child: _showNavPage()))),
        bottomSheet: Container(
            color: Colors.grey.shade200,
            height: 60.0,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ButtonNavigation(
                      isActive:
                          _navigationStatus == NavigationStatus.flashcardsNav,
                      onPressed: () =>
                          switchNav(NavigationStatus.flashcardsNav)),
                  ButtonNavigation(
                      isActive:
                          _navigationStatus == NavigationStatus.matchingNav,
                      onPressed: () => switchNav(NavigationStatus.matchingNav)),
                  ButtonNavigation(
                      isActive:
                          _navigationStatus == NavigationStatus.derdiedasNav,
                      onPressed: () =>
                          switchNav(NavigationStatus.derdiedasNav)),
                ])));
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
