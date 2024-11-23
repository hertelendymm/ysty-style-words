import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ysty_style_words/constants.dart';
import 'package:ysty_style_words/services/category_services.dart';
import 'package:ysty_style_words/widgets/appbar_secondary.dart';
import 'package:ysty_style_words/word_lists/flashcard_content.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage(
      {super.key, required this.onRefresh, required this.language});

  final VoidCallback onRefresh;
  final String language;

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  String? _selectedCategory;
  final box = GetStorage();
  List<String> knownWordIDs = [];
  bool isLoading = true;

  saveSelectedCategory(String category) {
    CategoryService.saveSelectedCategory(category);
    getSelectedCategory();
    closePage();
  }

  getSelectedCategory() {
    setState(() {
      isLoading = true;
      CategoryService.loadSelectedCategory().then((categoryName) {
        if (categoryName != null) {
          // Use the categoryName to load relevant content
          setState(() {
            _selectedCategory = categoryName;
          });
        }
      });
      knownWordIDs = getKnownWordIDs();
      isLoading = false;
    });

  }

  closePage() {
    Navigator.pop(context);
    widget.onRefresh();
  }

  @override
  void initState() {
    super.initState();
    getSelectedCategory();
  }

  List<String> getKnownWordIDs(){
    // List<String>? myList = box.read('knownWordIDs');
    List<String>? myList = box.read('knownWordIDs')?.cast<String>();
    myList ??= [];

    box.write('my_list', myList);
    return myList;
  }

  int getCategoryPercentage(String category){
    int count = 0;
    for (String item in knownWordIDs) {
      if (item.startsWith(category)) {
        count++;
      }
    }

    int percentage = (count / flashcardContents[category]!.length *100).round();
    print('The count of "$category" is $count');
    print('Percentage for "$category" is $percentage');
    return percentage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(

            ///TODO: Replace this with a ListView builder
            child: Column(
          children: [
            AppBarSecondary(
              onPressed: () => closePage(),
              title: category_page_appbartitle[widget.language]!,
            ),
            // _showAppBar(),
            isLoading ?
                const CircularProgressIndicator(color: Colors.blue)
                : Expanded(
                child: ListView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
              children: [
                _categoryItem(categoryId: "food"),
                _categoryItem(categoryId: "animal"),
                _categoryItem(categoryId: "transportation"),
                _categoryItem(categoryId: "family"),
                _categoryItem(categoryId: "sport"),
                _categoryItem(categoryId: "home"),
                _categoryItem(categoryId: "travel"),
                _categoryItem(categoryId: "education"),
                _categoryItem(categoryId: "clothing"),
                _categoryItem(categoryId: "music"),
                _categoryItem(categoryId: "school"),
                _categoryItem(categoryId: "space"),
                _categoryItem(categoryId: "nature"),
                _categoryItem(categoryId: "fruits"),
                _categoryItem(categoryId: "vegetables"),
                _categoryItem(categoryId: "body"),
                _categoryItem(categoryId: "hospital"),
                _categoryItem(categoryId: "office"),
                _categoryItem(categoryId: "jobs"),
                _categoryItem(categoryId: "dining"),
                _categoryItem(categoryId: "weather"),
                _categoryItem(categoryId: "verbs"),
                _categoryItem(categoryId: "technology"),
                _categoryItem(categoryId: "hobbies"),
                _categoryItem(categoryId: "colors"),
                _categoryItem(categoryId: "time"),
                _categoryItem(categoryId: "numbers"),
                _categoryItem(categoryId: "emotions"),
                _categoryItem(categoryId: "seasons"),
                _categoryItem(categoryId: "countries and cities"),
              ],
            ))
          ],
        )));
  }

  // Widget _showAppBar() {
  //   return Container(
  //     color: Colors.white,
  //     child: Column(
  //       children: [
  //         Padding(
  //           padding: const EdgeInsets.symmetric(horizontal: 20.0),
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             children: [
  //               GestureDetector(
  //                 onTap: () => closePage(),
  //                 child: Container(
  //                   padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
  //                   child: Container(
  //                     padding: const EdgeInsets.all(10.0),
  //                     decoration: BoxDecoration(
  //                       borderRadius: BorderRadius.circular(25.0),
  //                       color: Colors.grey.shade200,
  //                     ),
  //                     child: const Icon(FontAwesomeIcons.xmark,
  //                         color: Colors.black),
  //                   ),
  //                 ),
  //               ),
  //               Expanded(
  //                 child: Container(
  //                   padding: const EdgeInsets.symmetric(
  //                       horizontal: 0.0, vertical: 6.0),
  //                   child: const Center(
  //                       child: Text(
  //                     "Choose a Category",
  //                     style: TextStyle(
  //                         fontWeight: FontWeight.bold, fontSize: 24.0),
  //                     textAlign: TextAlign.center,
  //                   )),
  //                 ),
  //               ),
  //               const SizedBox(width: 45.0),
  //             ],
  //           ),
  //         ),
  //         const SizedBox(height: 20.0),
  //         Container(color: Colors.grey.shade200, height: 2.0),
  //       ],
  //     ),
  //   );
  // }

  Widget _categoryItem({
    required String categoryId,
    // required String title,
    // IconData icon = FontAwesomeIcons.x,
  }) {
    bool isActive = categoryId == _selectedCategory;
    int percent = getCategoryPercentage(categoryId);
    return GestureDetector(
      onTap: () => saveSelectedCategory(categoryId),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 0.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.grey.shade300, width: 1),
          color: isActive ? Colors.black : Colors.grey.shade100,
        ),
        child: Row(
          children: [
            Icon(categories[categoryId]["icon"]!,
                color: isActive ? Colors.white : Colors.black),
            const SizedBox(width: 20.0),
            Text(categories[categoryId][widget.language]!,
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: isActive ? Colors.white : Colors.black)),
            const Expanded(child: SizedBox()),
            Text("$percent %",
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: isActive ? Colors.white : Colors.black)),
          ],
        ),
      ),
    );
  }
}

// "Food"
// "Animal"
// "Transportation"
// "Family"
// "Sport"
// "Home"
// "Travel"
// "Education"
// "Clothing"
// "Music"
// "School
// "Space"
// "Nature"
// "Fruits"
// "Vegetables"
// "Body"
// "Hospital"
// "Office"
// "Jobs"
// "Dinig"
// "Weather"
// "Verbs"
