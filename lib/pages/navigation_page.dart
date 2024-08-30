import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ysty_style_words/pages/categories_page.dart';
import 'package:ysty_style_words/pages/derdiedas_page.dart';
import 'package:ysty_style_words/pages/flashcards_page.dart';
import 'package:ysty_style_words/pages/matching_page.dart';
import 'package:ysty_style_words/pages/settings_page.dart';
import 'package:ysty_style_words/services/category_services.dart';
import '../widgets/button_navigation.dart';

enum NavigationStatus { flashcards_nav, matching_nav, derdiedas_nav }

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  NavigationStatus _navigationStatus = NavigationStatus.flashcards_nav;
  String? _selectedCategory;
  bool _isLoading = true;

  void switchNav(NavigationStatus newNavStatus) {
    setState(() {
      _navigationStatus = newNavStatus;
    });
  }



  void refreshPage() {
    setState(() {
      print("refressed nav page =================================");
      _isLoading = true;
      _loadSelectedCategory();
    });
  }

  @override
  void initState() {
    super.initState();
    refreshPage();
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
      // appBar: const MainAppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 60.0),
          child: Column(
            children: [
              _myAppBar(),
              Expanded(child: _showNavPage()),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        color: Colors.grey.shade200,
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
        ),
      ),
    );
  }

  Widget _myAppBar() {
    return Column(
      children: [
        Container(
          height: kToolbarHeight + 12,
          margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              CategoriesPage(onRefresh: refreshPage))),
                  child: Container(
                    // height: 40.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40.0),
                      border: Border.all(color: Colors.grey.shade300, width: 3),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 0.0, vertical: 6.0),
                    margin: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 12.0),
                    // padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Center(
                        child: Text(
                      _isLoading
                          ? ""
                          : _selectedCategory ?? "Select a Category",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                      textAlign: TextAlign.center,
                    )),
                  ),
                ),
              ),
              const SizedBox(
                width: 20.0,
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingsPage())),
                child: Container(
                  // color: Colors.red,
                  padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                  // const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        color: Colors.grey.shade200),
                    child:
                        const Icon(FontAwesomeIcons.gear, color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          color: Colors.grey.shade200,
          height: 2.0,
        ),
      ],
    );
  }

   _showNavPage() {
    if (_isLoading) {
      return const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
        ],
      );
    }else {
      switch (_navigationStatus) {
        case NavigationStatus.flashcards_nav:
          return FlashcardsPage(selectedCategory: _selectedCategory ?? "Animal");
        case NavigationStatus.matching_nav:
          return MatchingPage(selectedCategory: _selectedCategory ?? "Animal");
        case NavigationStatus.derdiedas_nav:
          return DerDieDasPage(selectedCategory: _selectedCategory ?? "Animal");
        default:
          return FlashcardsPage(selectedCategory: _selectedCategory ?? "Animal");
      }
    }
  }
}
