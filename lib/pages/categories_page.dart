import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: ()=> Navigator.pop(context),
          child: Icon(FontAwesomeIcons.xmark, size: 30.0,),
        ),
        title: Text("Choose a category"),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            ListTile(title: Text("Food"),leading: Icon(FontAwesomeIcons.bowlFood), tileColor: Colors.white, ),
            ListTile(title: Text("Animal"),leading: Icon(FontAwesomeIcons.dog), tileColor: Colors.white,),
            ListTile(title: Text("Transportation"),leading: Icon(FontAwesomeIcons.car), tileColor: Colors.white,),
            ListTile(title: Text("Family"),leading: Icon(FontAwesomeIcons.peopleGroup), tileColor: Colors.white,),
            ListTile(title: Text("Sport"),leading: Icon(FontAwesomeIcons.personSkiing), tileColor: Colors.white,),
            ListTile(title: Text("Home"),leading: Icon(FontAwesomeIcons.house), tileColor: Colors.white,),
            ListTile(title: Text("Travel"),leading: Icon(FontAwesomeIcons.plane), tileColor: Colors.white,),
            ListTile(title: Text("Education"),leading: Icon(FontAwesomeIcons.spellCheck), tileColor: Colors.white,),
            ListTile(title: Text("Clothing"),leading: Icon(FontAwesomeIcons.shirt), tileColor: Colors.white,),
            ListTile(title: Text("Music"),leading: Icon(FontAwesomeIcons.music), tileColor: Colors.white,),
            ListTile(title: Text("School"),leading: Icon(FontAwesomeIcons.graduationCap), tileColor: Colors.white,),
            ListTile(title: Text("Space"),leading: Icon(FontAwesomeIcons.rocket), tileColor: Colors.white,),
            ListTile(title: Text("Nature"),leading: Icon(FontAwesomeIcons.tree), tileColor: Colors.white,),
            ListTile(title: Text("Fruits"),leading: Icon(FontAwesomeIcons.lemon), tileColor: Colors.white,),
            ListTile(title: Text("Vegetables"),leading: Icon(FontAwesomeIcons.carrot), tileColor: Colors.white,),
            ListTile(title: Text("Body"),leading: Icon(FontAwesomeIcons.skull), tileColor: Colors.white,),
            ListTile(title: Text("Hospital"),leading: Icon(FontAwesomeIcons.hospital), tileColor: Colors.white,),
            ListTile(title: Text("Office"),leading: Icon(FontAwesomeIcons.briefcase), tileColor: Colors.white,),
            ListTile(title: Text("Jobs"),leading: Icon(FontAwesomeIcons.hammer), tileColor: Colors.white,),
            ListTile(title: Text("Dinig"),leading: Icon(FontAwesomeIcons.utensils), tileColor: Colors.white,),
            ListTile(title: Text("Weather"),leading: Icon(FontAwesomeIcons.cloudSunRain), tileColor: Colors.white,),
            ListTile(title: Text("Verbs"),leading: Icon(FontAwesomeIcons.comment), tileColor: Colors.white,),
          ],
        ),
      ),
    );
  }
}
