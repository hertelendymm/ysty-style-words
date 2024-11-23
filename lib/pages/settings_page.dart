import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ysty_style_words/constants.dart';
import 'package:ysty_style_words/widgets/appbar_secondary.dart';
import 'package:ysty_style_words/widgets/title_w_sparator.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key, required this.onRefresh});

  final VoidCallback onRefresh;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // bool _isEngLang = true;
  String _language = "english";
  final box = GetStorage();
  List<String> knownWordIDs = [];
  bool isLoading = true;
  String allKnownWordsCounter = 'N/A';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _loadBoolIsEngLang();
    _loadLanguage();
    allKnownWordsCounter = getKnownWordIDsSize();
  }

  // Future<void> _loadBoolIsEngLang() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     _isEngLang = prefs.getBool('isEngLang') ?? true;
  //   });
  // }
  Future<void> _loadLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _language = prefs.getString('language') ?? "english";
    });
  }

  Future<void> _saveLanguage(String language) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('language', language);

    /// update parent with new language setting
    widget.onRefresh();
  }

  String getKnownWordIDsSize() {
    // List<String>? myList = box.read('knownWordIDs');
    List<String>? myList = box.read('knownWordIDs')?.cast<String>();
    myList ??= [];

    box.write('my_list', myList);
    return '${myList.length}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: const SecondaryAppBar(title: "Settings"),
      body: SafeArea(
        child: Column(
          children: [
            AppBarSecondary(
                onPressed: () => Navigator.pop(context), title: 'Ysty Style'),
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
                        child: Column(
                          children: [
                            allKnownWordsCounter == 'N/A'
                                ? const CircularProgressIndicator(color: Colors.black)
                                : Text(allKnownWordsCounter,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 80.0,
                                    fontWeight: FontWeight.bold)),
                            Text(settings_page_totalwords[_language]!,
                                // "Your total word count",
                                style: const TextStyle(
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
                            child: Column(
                              children: [
                                Text("89%",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 30.0,
                                        fontWeight: FontWeight.bold)),
                                Text(
                                  textAlign: TextAlign.center,
                                  settings_page_derdiedas[_language]!,
                                  overflow: TextOverflow.ellipsis,
                                  // "Der/Die/Das stat",
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
                            child: Column(
                              children: [
                                Text("75",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 30.0,
                                        fontWeight: FontWeight.bold)),
                                Text(
                                  settings_page_timetrial[_language]!,
                                  // "High Score",
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                ),
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
                          Flexible(
                              child:
                                  _languageButton(buttonLanguage: "english")),
                          // isActive: _language == "english", isEngLangCard: true)),
                          const SizedBox(width: 20.0),
                          Flexible(
                              child:
                                  _languageButton(buttonLanguage: "hungarian")),
                          // isActive: _language == "hungarian", isEngLangCard: false)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    TitleWSeparator(title: settings_page_links[_language]!),
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

  Widget _languageButton({required String buttonLanguage}) {
    // {required bool isActive, required bool isEngLangCard}) {
    return GestureDetector(
      onTap: () {
        // if (!isActive) {
        if (_language != buttonLanguage) {
          setState(() {
            // _isEngLang = !_isEngLang;
            _language = buttonLanguage;
          });
          // _saveBoolIsEngLang(_isEngLang);
          _saveLanguage(buttonLanguage);
        }
      },
      child: Expanded(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                  color: _language == buttonLanguage
                      ? Colors.black
                      : Colors.grey.shade200,
                  width: 3),
              color: _language == buttonLanguage ? Colors.black : Colors.white),
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          child: Row(
            children: [
              Image.asset(
                buttonLanguage == "english"
                    ? 'assets/images/uk_flag_icon.png'
                    : 'assets/images/magyar_flag_icon.png',
                width: 36.0,
                height: 36.0,
              ),
              const SizedBox(width: 20.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(buttonLanguage == "english" ? 'English' : 'Magyar',
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: _language == buttonLanguage
                              ? Colors.white
                              : Colors.grey)),
                  Text(buttonLanguage == "english" ? 'German' : 'Német',
                      style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: _language == buttonLanguage
                              ? Colors.white
                              : Colors.grey)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
