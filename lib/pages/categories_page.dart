import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ysty_style_words/services/category_services.dart';
import 'package:ysty_style_words/widgets/title_w_sparator.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key, required this.onRefresh});

  final VoidCallback onRefresh;


  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {

  String? _selectedCategory;

  saveSelectedCategory(String category){
    CategoryService.saveSelectedCategory(category);
    getSelectedCategory();
    closePage();
  }

  // getSelectedCategory() async {
  //   String? selectedCategory = await CategoryService.loadSelectedCategory();
  //   if (selectedCategory != null) {
  //     setState(() {
  //       _selectedCategory = _selectedCategory;
  //     });
  //   }
  // }

  getSelectedCategory(){
    CategoryService.loadSelectedCategory().then((categoryName) {
      if (categoryName != null) {
        // Use the categoryName to load relevant content
        setState(() {
          _selectedCategory = categoryName;
        });
      }
    });
  }

  closePage(){
    Navigator.pop(context);
    widget.onRefresh();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSelectedCategory();
  }

  // Future<void> saveSelectedCategory(String categoryName) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('selectedCategory', categoryName);
  //
  //   setState(() {
  //     _selectedCategory = categoryName;
  //   });
  // }
  //
  // Future<String?> loadSelectedCategory() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.getString('selectedCategory');
  // }
  //
  // @override
  // void initState() {
  //   super.initState();
  //   loadSelectedCategory().then((categoryName) {
  //     if (categoryName != null) {
  //       setState(() {
  //         _selectedCategory = categoryName;
  //       });
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: const SecondaryAppBar(title: 'Choose a category',),
      body: SafeArea(
        ///TODO: Replace this with a ListView builder
        child: Column(
          children: [
          _showAppBar(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                children:  [
                  const TitleWSeparator(title: "A1-A2"),
                  _categotyItem(title: "Food", icon: FontAwesomeIcons.bowlFood),
                  _categotyItem(title: "Animal", icon: FontAwesomeIcons.dog),
                  // _categotyItem(title: "Transportation", icon: FontAwesomeIcons.car),
                  // _categotyItem(title: "Family", icon: FontAwesomeIcons.peopleGroup),
                  // _categotyItem(title: "Sport", icon: FontAwesomeIcons.personSkiing),
                  // _categotyItem(title: "Home", icon: FontAwesomeIcons.house),
                  // _categotyItem(title: "Travel", icon: FontAwesomeIcons.plane),
                  // _categotyItem(title: "Education", icon: FontAwesomeIcons.spellCheck),
                  // _categotyItem(title: "Clothing", icon: FontAwesomeIcons.shirt),
                  // _categotyItem(title: "Music", icon: FontAwesomeIcons.music),
                  // _categotyItem(title: "School", icon: FontAwesomeIcons.graduationCap),
                  // _categotyItem(title: "Space", icon: FontAwesomeIcons.rocket),
                  // _categotyItem(title: "Nature", icon: FontAwesomeIcons.tree),
                  // _categotyItem(title: "Fruits", icon: FontAwesomeIcons.lemon),
                  // _categotyItem(title: "Vegetables", icon: FontAwesomeIcons.carrot),
                  // _categotyItem(title: "Body", icon: FontAwesomeIcons.skull),
                  // _categotyItem(title: "Hospital", icon: FontAwesomeIcons.hospital),
                  // _categotyItem(title: "Office", icon: FontAwesomeIcons.briefcase),
                  // _categotyItem(title: "Jobs", icon: FontAwesomeIcons.hammer),
                  // _categotyItem(title: "Dinig", icon: FontAwesomeIcons.utensils),
                  // _categotyItem(title: "Weather", icon: FontAwesomeIcons.cloudSunRain),
                  // _categotyItem(title: "Verbs", icon: FontAwesomeIcons.comment),
                  // TitleWSeparator(level: "B1-B2"),
                  // _categotyItem(title: "Food", icon: FontAwesomeIcons.bowlFood),
                  // _categotyItem(title: "Animal", icon: FontAwesomeIcons.dog),
                  // _categotyItem(title: "Transportation", icon: FontAwesomeIcons.car),
                  // _categotyItem(title: "Family", icon: FontAwesomeIcons.peopleGroup),
                  // _categotyItem(title: "Sport", icon: FontAwesomeIcons.personSkiing),
                  // _categotyItem(title: "Home", icon: FontAwesomeIcons.house),
                  // _categotyItem(title: "Travel", icon: FontAwesomeIcons.plane),
                  // _categotyItem(title: "Education", icon: FontAwesomeIcons.spellCheck),
                  // _categotyItem(title: "Clothing", icon: FontAwesomeIcons.shirt),
                  // _categotyItem(title: "Music", icon: FontAwesomeIcons.music),
                  // _categotyItem(title: "School", icon: FontAwesomeIcons.graduationCap),
                  // _categotyItem(title: "Space", icon: FontAwesomeIcons.rocket),
                  // _categotyItem(title: "Nature", icon: FontAwesomeIcons.tree),
                  // _categotyItem(title: "Fruits", icon: FontAwesomeIcons.lemon),
                  // _categotyItem(title: "Vegetables", icon: FontAwesomeIcons.carrot),
                  // _categotyItem(title: "Body", icon: FontAwesomeIcons.skull),
                  // _categotyItem(title: "Hospital", icon: FontAwesomeIcons.hospital),
                  // _categotyItem(title: "Office", icon: FontAwesomeIcons.briefcase),
                  // _categotyItem(title: "Jobs", icon: FontAwesomeIcons.hammer),
                  // _categotyItem(title: "Dinig", icon: FontAwesomeIcons.utensils),
                  // _categotyItem(title: "Weather", icon: FontAwesomeIcons.cloudSunRain),
                  // _categotyItem(title: "Verbs", icon: FontAwesomeIcons.comment),
                  // TitleWSeparator(level: "C1-C2"),
                  // _categotyItem(title: "Food", icon: FontAwesomeIcons.bowlFood),
                  // _categotyItem(title: "Animal", icon: FontAwesomeIcons.dog),
                  // _categotyItem(title: "Transportation", icon: FontAwesomeIcons.car),
                  // _categotyItem(title: "Family", icon: FontAwesomeIcons.peopleGroup),
                  // _categotyItem(title: "Sport", icon: FontAwesomeIcons.personSkiing),
                  // _categotyItem(title: "Home", icon: FontAwesomeIcons.house),
                  // _categotyItem(title: "Travel", icon: FontAwesomeIcons.plane),
                  // _categotyItem(title: "Education", icon: FontAwesomeIcons.spellCheck),
                  // _categotyItem(title: "Clothing", icon: FontAwesomeIcons.shirt),
                  // _categotyItem(title: "Music", icon: FontAwesomeIcons.music),
                  // _categotyItem(title: "School", icon: FontAwesomeIcons.graduationCap),
                  // _categotyItem(title: "Space", icon: FontAwesomeIcons.rocket),
                  // _categotyItem(title: "Nature", icon: FontAwesomeIcons.tree),
                  // _categotyItem(title: "Fruits", icon: FontAwesomeIcons.lemon),
                  // _categotyItem(title: "Vegetables", icon: FontAwesomeIcons.carrot),
                  // _categotyItem(title: "Body", icon: FontAwesomeIcons.skull),
                  // _categotyItem(title: "Hospital", icon: FontAwesomeIcons.hospital),
                  // _categotyItem(title: "Office", icon: FontAwesomeIcons.briefcase),
                  // _categotyItem(title: "Jobs", icon: FontAwesomeIcons.hammer),
                  // _categotyItem(title: "Dinig", icon: FontAwesomeIcons.utensils),
                  // _categotyItem(title: "Weather", icon: FontAwesomeIcons.cloudSunRain),
                  // _categotyItem(title: "Verbs", icon: FontAwesomeIcons.comment),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _showAppBar(){
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => closePage(),
                  child: Container(
                    // color: Colors.red,
                    padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                    // const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        color: Colors.grey.shade200,
                      ),
                      child:
                      const Icon(FontAwesomeIcons.xmark, color: Colors.black),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    // height: 40.0,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 0.0, vertical: 6.0),
                    child: const Center(
                        child: Text(
                          "Choose a Category",
                          style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
                          textAlign: TextAlign.center,
                        )),
                  ),
                ),
                const SizedBox(width: 45.0),
              ],
            ),
          ),
          const SizedBox(height: 20.0),
          Container(
            color: Colors.grey.shade200,
            height: 2.0,
          ),
        ],
      ),
    );
  }

  Widget _categotyItem({required String title, IconData icon = FontAwesomeIcons.x}){
    bool isActive = title == _selectedCategory;
    return GestureDetector(
      onTap: ()=> saveSelectedCategory(title),
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
            Text(title, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: isActive ? Colors.white : Colors.black)),
            const Expanded(child: SizedBox()),
            Text("0%", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: isActive ? Colors.white : Colors.black)),
          ],
        ),
      ),
    );
  }
}
