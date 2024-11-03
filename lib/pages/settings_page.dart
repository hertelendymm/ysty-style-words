import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ysty_style_words/widgets/appbar_secondary.dart';
import 'package:ysty_style_words/widgets/title_w_sparator.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // bool isEnglishChosenLang() {
  //   /// TODO: Get chosen language settings from SharedPref (hungarian-german or english-german) and english should be the default
  //   return false;
  // }

  bool _isEngLang = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadBoolIsEngLang();
  }

  Future<void> _loadBoolIsEngLang() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isEngLang = prefs.getBool('isEngLang') ?? true;
    });
  }

  Future<void> _saveBoolIsEngLang(bool isEngLang) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isEngLang', isEngLang);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: const SecondaryAppBar(title: "Settings"),
      body: SafeArea(
        child: Column(
          children: [
            AppBarSecondary(onPressed: ()=> Navigator.pop(context), title: 'Ysty Style'),
            // Container(
            //   color: Colors.white,
            //   child: Column(
            //     children: [
            //       Padding(
            //         padding: const EdgeInsets.symmetric(horizontal: 20.0),
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           crossAxisAlignment: CrossAxisAlignment.center,
            //           children: [
            //             GestureDetector(
            //               onTap: () {
            //                 Navigator.pop(context);
            //               },
            //               child: Container(
            //                 // color: Colors.red,
            //                 padding:
            //                     const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
            //                 // const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            //                 child: Container(
            //                   padding: const EdgeInsets.all(10.0),
            //                   decoration: BoxDecoration(
            //                     borderRadius: BorderRadius.circular(25.0),
            //                     color: Colors.grey.shade200,
            //                   ),
            //                   child: const Icon(FontAwesomeIcons.xmark,
            //                       color: Colors.black),
            //                 ),
            //               ),
            //             ),
            //             Expanded(
            //               child: Container(
            //                 // height: 40.0,
            //                 padding: const EdgeInsets.symmetric(
            //                     horizontal: 0.0, vertical: 6.0),
            //                 child: const Center(
            //                     child: Text(
            //                   "Settings",
            //                   style: TextStyle(
            //                       fontWeight: FontWeight.bold, fontSize: 24.0),
            //                   textAlign: TextAlign.center,
            //                 )),
            //               ),
            //             ),
            //             const SizedBox(width: 45.0),
            //           ],
            //         ),
            //       ),
            //       const SizedBox(height: 20.0),
            //       Container(
            //         color: Colors.grey.shade200,
            //         height: 2.0,
            //       ),
            //     ],
            //   ),
            // ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ListView(
                  children: [
                    const SizedBox(height: 20.0),
                    Container(
                      padding: const EdgeInsets.all(20.0),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 0.0, vertical: 5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border:
                            Border.all(color: Colors.grey.shade300, width: 1),
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 50.0),
                        child: const Column(
                          children: [
                            Text("1274",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 80.0,
                                    fontWeight: FontWeight.bold)),
                            Text("Your total word count",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 18.0)),
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
                              border: Border.all(
                                  color: Colors.grey.shade300, width: 1),
                              color: Colors.grey.shade100,
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 20.0),
                            child: const Column(
                              children: [
                                Text("89%",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 30.0,
                                        fontWeight: FontWeight.bold)),
                                Text(
                                  "Der/Die/Das",
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 20.0),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                  color: Colors.grey.shade300, width: 1),
                              color: Colors.grey.shade100,
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 20.0),
                            child: const Column(
                              children: [
                                Text("75",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 30.0,
                                        fontWeight: FontWeight.bold)),
                                Text("High Score"),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    const TitleWSeparator(title: "Spracheinstellungen"),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(child: _languageButton(isActive: _isEngLang, isEngLangCard: true)),
                          const SizedBox(width: 20.0),
                          Flexible(child: _languageButton(isActive: !_isEngLang, isEngLangCard: false)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    const TitleWSeparator(title: "Links"),
                    _tempLinkButton('Link 1'),
                    _tempLinkButton('Link 2'),
                    _tempLinkButton('Link 3'),
                    _tempLinkButton('Link 4'),
                    _tempLinkButton('Link 5'),
                    _tempLinkButton('Link 6'),
                    _tempLinkButton('More apps'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tempLinkButton(String title) {
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
              style:
                  const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            ),
            const Icon(
              FontAwesomeIcons.arrowRight,
              size: 30.0,
            ),
          ],
        ));
  }

  Widget _languageButton({required bool isActive, required bool isEngLangCard}) {
    return GestureDetector(
      onTap: (){
        if(!isActive) {
          setState(() {
            _isEngLang = !_isEngLang;
          });
          _saveBoolIsEngLang(_isEngLang);
        }
      },
      child: Expanded(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                  color: isActive ? Colors.black : Colors.grey.shade200,
                  width: 3),
              color: isActive ? Colors.black : Colors.white),
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          child: Row(
            children: [
              Image.asset(
                isEngLangCard
                    ? 'assets/images/uk_flag_icon.png'
                    : 'assets/images/magyar_flag_icon.png',
                width: 36.0,
                height: 36.0,
              ),
              const SizedBox(width: 20.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(isEngLangCard ? 'English' : 'Magyar',
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: isActive ? Colors.white : Colors.grey)),
                  Text(isEngLangCard ? 'German' : 'Német',
                      style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: isActive ? Colors.white : Colors.grey)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
