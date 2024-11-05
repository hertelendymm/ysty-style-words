import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ysty_style_words/constants.dart';
import 'package:ysty_style_words/services/category_services.dart';
import 'package:ysty_style_words/widgets/appbar_secondary.dart';

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

  saveSelectedCategory(String category) {
    CategoryService.saveSelectedCategory(category);
    getSelectedCategory();
    closePage();
  }

  getSelectedCategory() {
    CategoryService.loadSelectedCategory().then((categoryName) {
      if (categoryName != null) {
        // Use the categoryName to load relevant content
        setState(() {
          _selectedCategory = categoryName;
        });
      }
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
            Expanded(
                child: ListView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
              children: [
                _categoryItem(id: "food"),
                _categoryItem(id: "animal"),
                _categoryItem(id: "transportation"),
                _categoryItem(id: "family"),
                _categoryItem(id: "sport"),
                _categoryItem(id: "home"),
                _categoryItem(id: "travel"),
                _categoryItem(id: "education"),
                _categoryItem(id: "clothing"),
                _categoryItem(id: "music"),
                _categoryItem(id: "school"),
                _categoryItem(id: "space"),
                _categoryItem(id: "nature"),
                _categoryItem(id: "fruits"),
                _categoryItem(id: "vegetables"),
                _categoryItem(id: "body"),
                _categoryItem(id: "hospital"),
                _categoryItem(id: "office"),
                _categoryItem(id: "jobs"),
                _categoryItem(id: "dining"),
                _categoryItem(id: "weather"),
                _categoryItem(id: "verbs"),
                _categoryItem(id: "technology"),
                _categoryItem(id: "hobbies"),
                _categoryItem(id: "colors"),
                _categoryItem(id: "time"),
                _categoryItem(id: "numbers"),
                _categoryItem(id: "emotions"),
                _categoryItem(id: "seasons"),
                _categoryItem(id: "countries and cities"),
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
    required String id,
    // required String title,
    // IconData icon = FontAwesomeIcons.x,
  }) {
    bool isActive = id == _selectedCategory;
    return GestureDetector(
      onTap: () => saveSelectedCategory(id),
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
            Icon(categories[id]["icon"]!,
                color: isActive ? Colors.white : Colors.black),
            const SizedBox(width: 20.0),
            Text(categories[id][widget.language]!,
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: isActive ? Colors.white : Colors.black)),
            const Expanded(child: SizedBox()),
            Text("0%",
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
