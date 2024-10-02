import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ysty_style_words/pages/derdiedas_page.dart';
import 'package:ysty_style_words/pages/flashcards_page.dart';
import 'package:ysty_style_words/pages/matching_page.dart';
import 'package:ysty_style_words/services/category_services.dart';
import 'package:ysty_style_words/widgets/loading_screen.dart';
import 'package:ysty_style_words/widgets/main_app_bar.dart';
import '../widgets/button_navigation.dart';

enum NavigationStatus { flashcardsNav, matchingNav, derdiedasNav }

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  NavigationStatus _navigationStatus = NavigationStatus.flashcardsNav;
  bool _isLoading = true;
  String? _selectedCategory;

  void switchNav(NavigationStatus newNavStatus) {
    setState(() {
      _navigationStatus = newNavStatus;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadSelectedCategory();
  }

  Future<void> _loadSelectedCategory() async {
    _isLoading = true;
    print("=+=+===+==++===+==");
    String? categoryName = await CategoryService.loadSelectedCategory();
    setState(() {
      _selectedCategory = categoryName;
    });
    _isLoading = false; // Update loading state after data is loaded
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.only(bottom: 60.0),
                child: Column(
                  children: [
                    MainAppBar(
                        updateParent: _loadSelectedCategory,
                        selectedCategory: _selectedCategory.toString()),
                   Expanded(child: _showNavPage()),
                  ],
                ))),
        // child: Expanded(child: _showNavPage()))),
        bottomSheet: Container(
            color: Colors.grey.shade100,
            // color: Colors.grey.shade200,
            // height: 62.0,
            height: 60.0,
            child: Column(
              children: [
                // Container(color: Colors.grey.shade200, height: 2.0),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ButtonNavigation(
                        isActive:
                            _navigationStatus == NavigationStatus.flashcardsNav,
                        onPressed: () =>
                            switchNav(NavigationStatus.flashcardsNav),
                        iconData: FontAwesomeIcons.house,
                      ),
                      ButtonNavigation(
                        isActive:
                            _navigationStatus == NavigationStatus.matchingNav,
                        onPressed: () =>
                            switchNav(NavigationStatus.matchingNav),
                        iconData: FontAwesomeIcons.hourglassHalf,
                      ),
                      ButtonNavigation(
                        isActive:
                            _navigationStatus == NavigationStatus.derdiedasNav,
                        onPressed: () =>
                            switchNav(NavigationStatus.derdiedasNav),
                        iconData: FontAwesomeIcons.language,
                      ),
                    ]),
              ],
            )));
  }

  _showNavPage() {
    print("_showNavPage");
    if (_isLoading) {
      print('loading');
      return LoadingScreen();
    } else {
      switch (_navigationStatus) {
        case NavigationStatus.flashcardsNav:
          return FlashcardsPage(category: _selectedCategory!);
        case NavigationStatus.matchingNav:
          return MatchingPage(category: _selectedCategory!);
        case NavigationStatus.derdiedasNav:
          return DerDieDasPage(category: _selectedCategory!);
        default:
          return LoadingScreen();
          // return FlashcardsPage(category: _selectedCategory!);
      }
    }
  }
}
