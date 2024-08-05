import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../widgets/navigation_button.dart';

enum NavigationStatus {
  flashcards_nav,
  matching_nav,
  derdiedas_nav
}

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  NavigationStatus _navigationStatus = NavigationStatus.flashcards_nav;

  void switchNav(NavigationStatus newNavStatus){
    print("before: $_navigationStatus");
    setState(() {
      _navigationStatus = newNavStatus;
    });
    print("after: $_navigationStatus");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(FontAwesomeIcons.circleUser),
            const SizedBox(width: 10.0,),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(color: Colors.grey, width: 3),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text("Category", style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
              ),
            ),
            const SizedBox(width: 10.0,),
            Icon(FontAwesomeIcons.gear),
          ],
        ),
        // centerTitle: true,
        
      ),
      body: SafeArea(
        child: Container(color: Colors.red,),
      ),
      bottomSheet: Container(color: Colors.grey.shade200,
        height: 60.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            NavigationButton(
              isActive: _navigationStatus == NavigationStatus.flashcards_nav,
              onPressed: () => switchNav(NavigationStatus.flashcards_nav),
            ),
            NavigationButton(
              isActive: _navigationStatus == NavigationStatus.matching_nav,
              onPressed: () => switchNav(NavigationStatus.matching_nav),
            ),
            NavigationButton(
              isActive: _navigationStatus == NavigationStatus.derdiedas_nav,
              onPressed: () => switchNav(NavigationStatus.derdiedas_nav),
            ),
          ],
        ),),
    );
  }
}
