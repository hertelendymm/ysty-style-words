import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ysty_style_words/services/category_services.dart';
import 'package:ysty_style_words/widgets/appbar_secondary.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key, required this.onRefresh});

  final VoidCallback onRefresh;

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
            AppBarSecondary(onPressed: ()=> closePage(), title: 'Choose a category'),
            // _showAppBar(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                children: [
                  _categoryItem(title: "Food", icon: FontAwesomeIcons.bowlFood),
                  _categoryItem(title: "Animal", icon: FontAwesomeIcons.dog),
                  _categoryItem(title: "Transportation", icon: FontAwesomeIcons.car),
                  _categoryItem(title: "Family", icon: FontAwesomeIcons.peopleGroup),
                  _categoryItem(title: "Sport", icon: FontAwesomeIcons.personSkiing),
                  _categoryItem(title: "Home", icon: FontAwesomeIcons.house),
                  _categoryItem(title: "Travel", icon: FontAwesomeIcons.plane),
                  _categoryItem(title: "Education", icon: FontAwesomeIcons.spellCheck),
                  _categoryItem(title: "Clothing", icon: FontAwesomeIcons.shirt),
                  _categoryItem(title: "Music", icon: FontAwesomeIcons.music),
                  _categoryItem(title: "School", icon: FontAwesomeIcons.graduationCap),
                  _categoryItem(title: "Space", icon: FontAwesomeIcons.rocket),
                  _categoryItem(title: "Nature", icon: FontAwesomeIcons.tree),
                  _categoryItem(title: "Fruits", icon: FontAwesomeIcons.lemon),
                  _categoryItem(title: "Vegetables", icon: FontAwesomeIcons.carrot),
                  _categoryItem(title: "Body", icon: FontAwesomeIcons.skull),
                  _categoryItem(title: "Hospital", icon: FontAwesomeIcons.hospital),
                  _categoryItem(title: "Office", icon: FontAwesomeIcons.briefcase),
                  _categoryItem(title: "Jobs", icon: FontAwesomeIcons.hammer),
                  _categoryItem(title: "Dining", icon: FontAwesomeIcons.utensils),
                  _categoryItem(title: "Weather", icon: FontAwesomeIcons.cloudSunRain),
                  _categoryItem(title: "Verbs", icon: FontAwesomeIcons.comment),
                  _categoryItem(title: "Technology", icon: FontAwesomeIcons.microchip),
                  _categoryItem(title: "Hobbies", icon: FontAwesomeIcons.gamepad),
                  _categoryItem(title: "Colors", icon: FontAwesomeIcons.palette),
                  _categoryItem(title: "Time", icon: FontAwesomeIcons.hourglassHalf),
                  _categoryItem(title: "Numbers", icon: FontAwesomeIcons.listOl),
                  _categoryItem(title: "Emotions", icon: FontAwesomeIcons.faceGrinTears),
                  _categoryItem(title: "Seasons", icon: FontAwesomeIcons.snowflake),
                  _categoryItem(title: "Countries and Cities", icon: FontAwesomeIcons.earthAmericas),
                ],
              ),
            ),
          ],
        ),
      ),
    );
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
    required String title,
    IconData icon = FontAwesomeIcons.x,
  }) {
    bool isActive = title == _selectedCategory;
    return GestureDetector(
      onTap: () => saveSelectedCategory(title),
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
            Icon(icon, color: isActive ? Colors.white : Colors.black),
            const SizedBox(width: 20.0),
            Text(title,
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