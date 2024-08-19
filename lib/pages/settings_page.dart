import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ysty_style_words/widgets/button_rounded.dart';
import 'package:ysty_style_words/widgets/secondary_app_bar.dart';
import 'package:ysty_style_words/widgets/title_w_sparator.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  bool isEnglishChosenLang(){
    /// TODO: Get chosen language settings from SharedPref (hungarian-german or english-german) and english should be the default
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const SecondaryAppBar(title: "Settings"),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: ListView(
            children: [
              const SizedBox(height: 20.0),
              Container(
                padding: const EdgeInsets.all(20.0),
                margin: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.grey.shade300, width: 1),
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                  child: const Column(
                    children: [
                      Text("1274", style: TextStyle(color: Colors.black, fontSize: 80.0, fontWeight: FontWeight.bold)),
                      Text("Your total word count", style: TextStyle(color: Colors.grey, fontSize: 18.0)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: Colors.grey, width: 1),
                        color: Colors.black
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                      child: const Column(
                        children: [
                          Text("89%", style: TextStyle(color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.bold)),
                          Text("Der/Die/Das", style: TextStyle(color: Colors.white),),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 20.0),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: Colors.grey.shade300, width: 1),
                        color: Colors.grey.shade100,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                      child: const Column(
                        children: [
                          Text("75", style: TextStyle(color: Colors.black, fontSize: 30.0, fontWeight: FontWeight.bold)),
                          Text("High Score"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              const TitleWSeparator(level: "Spracheinstellungen"),
              Column(
                children: [
                  _languageButton(true),
                  const SizedBox(height: 10.0),
                  _languageButton(false),
                ],
              ),
              const SizedBox(height: 10.0),
              const TitleWSeparator(level: "Links"),
              _TempLinkButton('Link 1'),
              _TempLinkButton('Link 2'),
              _TempLinkButton('Link 3'),
              _TempLinkButton('Link 4'),
              _TempLinkButton('Link 5'),
              _TempLinkButton('Link 6'),
              _TempLinkButton('More apps'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _TempLinkButton(String title) {
    return Container(
        padding: const EdgeInsets.all(20.0),
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.grey.shade300, width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            ),
            const Icon(
              FontAwesomeIcons.arrowRight,
              size: 30.0,
            ),
          ],
        ));
  }

  Widget _languageButton(bool isActive){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: isActive ? Colors.blue : Colors.grey.shade200, width: 4),
        color: Colors.white
      ),
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child:  Row(
        children: [
          Image.asset(isActive ? 'images/uk_flag_icon.png':'images/magyar_flag_icon.png' , width: 50.0, height: 50.0,),
          SizedBox(width: 20.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  isActive ? 'English' :'Magyar',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: isActive ? Colors.blue : Colors.grey )
              ),
              Text(
                  isActive ? 'German':'Német' ,
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: isActive ? Colors.blue : Colors.grey)
              ),
            ],
          ),
        ],
      ),
    );
  }
}
