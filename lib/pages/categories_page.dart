import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ysty_style_words/widgets/secondary_app_bar.dart';
import 'package:ysty_style_words/widgets/title_w_sparator.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {

  String activeCard = "Family"; ///TODO: Replace this with a SharedPref call to get the current category

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const SecondaryAppBar(title: 'Choose a category',),
      body: SafeArea(
        ///TODO: Replace this with a ListView builder
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          children:  [
            TitleWSeparator(level: "A1-A2"),
            _categotyItem(title: "Food", icon: FontAwesomeIcons.bowlFood),
            _categotyItem(title: "Animal", icon: FontAwesomeIcons.dog),
            _categotyItem(title: "Transportation", icon: FontAwesomeIcons.car),
            _categotyItem(title: "Family", icon: FontAwesomeIcons.peopleGroup),
            _categotyItem(title: "Sport", icon: FontAwesomeIcons.personSkiing),
            _categotyItem(title: "Home", icon: FontAwesomeIcons.house),
            _categotyItem(title: "Travel", icon: FontAwesomeIcons.plane),
            _categotyItem(title: "Education", icon: FontAwesomeIcons.spellCheck),
            _categotyItem(title: "Clothing", icon: FontAwesomeIcons.shirt),
            _categotyItem(title: "Music", icon: FontAwesomeIcons.music),
            _categotyItem(title: "School", icon: FontAwesomeIcons.graduationCap),
            _categotyItem(title: "Space", icon: FontAwesomeIcons.rocket),
            _categotyItem(title: "Nature", icon: FontAwesomeIcons.tree),
            _categotyItem(title: "Fruits", icon: FontAwesomeIcons.lemon),
            _categotyItem(title: "Vegetables", icon: FontAwesomeIcons.carrot),
            _categotyItem(title: "Body", icon: FontAwesomeIcons.skull),
            _categotyItem(title: "Hospital", icon: FontAwesomeIcons.hospital),
            _categotyItem(title: "Office", icon: FontAwesomeIcons.briefcase),
            _categotyItem(title: "Jobs", icon: FontAwesomeIcons.hammer),
            _categotyItem(title: "Dinig", icon: FontAwesomeIcons.utensils),
            _categotyItem(title: "Weather", icon: FontAwesomeIcons.cloudSunRain),
            _categotyItem(title: "Verbs", icon: FontAwesomeIcons.comment),
            TitleWSeparator(level: "B1-B2"),
            _categotyItem(title: "Food", icon: FontAwesomeIcons.bowlFood),
            _categotyItem(title: "Animal", icon: FontAwesomeIcons.dog),
            _categotyItem(title: "Transportation", icon: FontAwesomeIcons.car),
            _categotyItem(title: "Family", icon: FontAwesomeIcons.peopleGroup),
            _categotyItem(title: "Sport", icon: FontAwesomeIcons.personSkiing),
            _categotyItem(title: "Home", icon: FontAwesomeIcons.house),
            _categotyItem(title: "Travel", icon: FontAwesomeIcons.plane),
            _categotyItem(title: "Education", icon: FontAwesomeIcons.spellCheck),
            _categotyItem(title: "Clothing", icon: FontAwesomeIcons.shirt),
            _categotyItem(title: "Music", icon: FontAwesomeIcons.music),
            _categotyItem(title: "School", icon: FontAwesomeIcons.graduationCap),
            _categotyItem(title: "Space", icon: FontAwesomeIcons.rocket),
            _categotyItem(title: "Nature", icon: FontAwesomeIcons.tree),
            _categotyItem(title: "Fruits", icon: FontAwesomeIcons.lemon),
            _categotyItem(title: "Vegetables", icon: FontAwesomeIcons.carrot),
            _categotyItem(title: "Body", icon: FontAwesomeIcons.skull),
            _categotyItem(title: "Hospital", icon: FontAwesomeIcons.hospital),
            _categotyItem(title: "Office", icon: FontAwesomeIcons.briefcase),
            _categotyItem(title: "Jobs", icon: FontAwesomeIcons.hammer),
            _categotyItem(title: "Dinig", icon: FontAwesomeIcons.utensils),
            _categotyItem(title: "Weather", icon: FontAwesomeIcons.cloudSunRain),
            _categotyItem(title: "Verbs", icon: FontAwesomeIcons.comment),
            TitleWSeparator(level: "C1-C2"),
            _categotyItem(title: "Food", icon: FontAwesomeIcons.bowlFood),
            _categotyItem(title: "Animal", icon: FontAwesomeIcons.dog),
            _categotyItem(title: "Transportation", icon: FontAwesomeIcons.car),
            _categotyItem(title: "Family", icon: FontAwesomeIcons.peopleGroup),
            _categotyItem(title: "Sport", icon: FontAwesomeIcons.personSkiing),
            _categotyItem(title: "Home", icon: FontAwesomeIcons.house),
            _categotyItem(title: "Travel", icon: FontAwesomeIcons.plane),
            _categotyItem(title: "Education", icon: FontAwesomeIcons.spellCheck),
            _categotyItem(title: "Clothing", icon: FontAwesomeIcons.shirt),
            _categotyItem(title: "Music", icon: FontAwesomeIcons.music),
            _categotyItem(title: "School", icon: FontAwesomeIcons.graduationCap),
            _categotyItem(title: "Space", icon: FontAwesomeIcons.rocket),
            _categotyItem(title: "Nature", icon: FontAwesomeIcons.tree),
            _categotyItem(title: "Fruits", icon: FontAwesomeIcons.lemon),
            _categotyItem(title: "Vegetables", icon: FontAwesomeIcons.carrot),
            _categotyItem(title: "Body", icon: FontAwesomeIcons.skull),
            _categotyItem(title: "Hospital", icon: FontAwesomeIcons.hospital),
            _categotyItem(title: "Office", icon: FontAwesomeIcons.briefcase),
            _categotyItem(title: "Jobs", icon: FontAwesomeIcons.hammer),
            _categotyItem(title: "Dinig", icon: FontAwesomeIcons.utensils),
            _categotyItem(title: "Weather", icon: FontAwesomeIcons.cloudSunRain),
            _categotyItem(title: "Verbs", icon: FontAwesomeIcons.comment),
          ],
        ),
      ),
    );
  }

  Widget _categotyItem({String title="----", IconData icon = FontAwesomeIcons.x}){
    bool isActive = title == activeCard;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
      margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 0.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.grey.shade300, width: 1),
        color: isActive ? Colors.black : Colors.grey.shade100,
      ),
      child: Row(
        children: [
          Icon(icon, color: isActive ? Colors.white : Colors.black),
          SizedBox(width: 20.0),
          Text(title, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: isActive ? Colors.white : Colors.black)),
        ],
      ),
    );
  }
}
