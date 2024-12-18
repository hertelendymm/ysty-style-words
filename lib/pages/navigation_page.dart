import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ysty_style_words/pages/derdiedas_page.dart';
import 'package:ysty_style_words/pages/flashcards_page.dart';
import 'package:ysty_style_words/pages/matching_page.dart';
import 'package:ysty_style_words/services/category_services.dart';
import 'package:ysty_style_words/widgets/loading_screen.dart';
import 'package:ysty_style_words/widgets/appbar_main.dart';
import '../widgets/button_navigation.dart';

enum NavigationStatus { flashcardsNav, matchingNav, derdiedasNav }

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  NavigationStatus _navigationStatus = NavigationStatus.flashcardsNav;
  bool _isLoadingLanguage = true;
  bool _isLoadingCategory = true;
  String? _selectedCategory;
  // bool _isEngLang = true;
  String _language = "english";

  @override
  void initState() {
    super.initState();
    _updatePages();
    // _loadSelectedCategory();
    // _loadLanguage();
  }

  void switchNav(NavigationStatus newNavStatus) {
    setState(() {
      _navigationStatus = newNavStatus;
    });
  }

  Future<void> _loadLanguage() async {
    _isLoadingLanguage =  true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _language = prefs.getString('language') ?? "english";
    });
    print('language: $_language');
    _isLoadingLanguage =  false;
  }

  Future<void> _loadSelectedCategory() async {
    _isLoadingCategory = true;
    // _isLoading = true;
    print("=+=+===+==++===+==");
    String? categoryName = await CategoryService.loadSelectedCategory();
    setState(() {
      _selectedCategory = categoryName;
    });
    // _isLoading = false; // Update loading state after data is loaded
    _isLoadingCategory = false;
  }

  _updatePages(){
    _loadSelectedCategory();
    _loadLanguage();
    // Update loading state after data is loaded
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.only(bottom: 0.0),
                // padding: const EdgeInsets.only(bottom: 60.0),
                child: (_isLoadingLanguage || _isLoadingCategory)
                    ? const LoadingScreen()
                    : Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppBarMain(
                        // updateParent: _loadSelectedCategory,
                        updateParent: _updatePages,
                        selectedCategory: _selectedCategory.toString(), language: _language,),
                   Expanded(child: _showNavPage()),
                Container(
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
                    ))
                  ],
                ))),
        // child: Expanded(child: _showNavPage()))),
        // bottomSheet: Container(
        //     color: Colors.grey.shade100,
        //     // color: Colors.grey.shade200,
        //     // height: 62.0,
        //     height: 60.0,
        //     child: Column(
        //       children: [
        //         // Container(color: Colors.grey.shade200, height: 2.0),
        //         Row(
        //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //             crossAxisAlignment: CrossAxisAlignment.center,
        //             children: [
        //               ButtonNavigation(
        //                 isActive:
        //                     _navigationStatus == NavigationStatus.flashcardsNav,
        //                 onPressed: () =>
        //                     switchNav(NavigationStatus.flashcardsNav),
        //                 iconData: FontAwesomeIcons.house,
        //               ),
        //               ButtonNavigation(
        //                 isActive:
        //                     _navigationStatus == NavigationStatus.matchingNav,
        //                 onPressed: () =>
        //                     switchNav(NavigationStatus.matchingNav),
        //                 iconData: FontAwesomeIcons.hourglassHalf,
        //               ),
        //               ButtonNavigation(
        //                 isActive:
        //                     _navigationStatus == NavigationStatus.derdiedasNav,
        //                 onPressed: () =>
        //                     switchNav(NavigationStatus.derdiedasNav),
        //                 iconData: FontAwesomeIcons.language,
        //               ),
        //             ]),
        //       ],
        //     ))
        );
  }

  _showNavPage() {
    print("_showNavPage");
    // if (_isLoadingLanguage || _isLoadingCategory) {
    //   print('loading');
    //   return const LoadingScreen();
    // } else {
      switch (_navigationStatus) {
        case NavigationStatus.flashcardsNav:
          return FlashcardsPage(category: _selectedCategory!, language: _language);
        case NavigationStatus.matchingNav:
          return MatchingPage(category: _selectedCategory!, language: _language);
        case NavigationStatus.derdiedasNav:
          return DerDieDasPage(category: _selectedCategory!, language: _language);
        default:
          return const LoadingScreen();
          // return FlashcardsPage(category: _selectedCategory!);
      }
    // }
  }
}
