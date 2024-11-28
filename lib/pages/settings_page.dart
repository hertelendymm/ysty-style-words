import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ysty_style_words/constants.dart';
import 'package:ysty_style_words/pages/derdiedas_help_page.dart';
import 'package:ysty_style_words/widgets/appbar_secondary.dart';
import 'package:ysty_style_words/widgets/title_w_sparator.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

const int maxFailedLoadAttempts = 10;

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
  int allKnownWordsCounter = -1;
  int _highScore = 0;

  RewardedAd? _rewardedAd;
  int _numRewardedLoadAttempts = 0;
  static final AdRequest request = AdRequest(
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    nonPersonalizedAds: true,
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _loadBoolIsEngLang();
    _loadLanguage();
    _createRewardedAd();
    _loadHighScore();
    allKnownWordsCounter = getKnownWordIDsSize();
  }

  @override
  void dispose() {
    super.dispose();
    _rewardedAd?.dispose();
  }

  Future<void> _loadHighScore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _highScore = prefs.getInt('highScore') ?? 0;
    });
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

  int getKnownWordIDsSize() {
    // List<String>? myList = box.read('knownWordIDs');
    List<String>? myList = box.read('knownWordIDs')?.cast<String>();
    myList ??= [];

    box.write('my_list', myList);
    return myList.length;
  }

  String getCEFRLevel(int vocabularyLevel) {
    for (String level in settings_cefr_vocabulary_levels.keys) {
      if (vocabularyLevel <= settings_cefr_vocabulary_levels[level]!) {
        return level;
      }
    }
    return "C2"; // Default to the highest level if not found
  }

  Future<void> _launchUrl({required String url}) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $uri');
    }
  }

  void _createRewardedAd() {
    RewardedAd.load(
        adUnitId: Platform.isAndroid
            ? 'ca-app-pub-3940256099942544/5224354917'
            : 'ca-app-pub-3940256099942544/1712485313',
        request: request,
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            print('$ad loaded.');
            _rewardedAd = ad;
            _numRewardedLoadAttempts = 0;
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('RewardedAd failed to load: $error');
            _rewardedAd = null;
            _numRewardedLoadAttempts += 1;
            if (_numRewardedLoadAttempts < maxFailedLoadAttempts) {
              _createRewardedAd();
            }
          },
        ));
  }

  void _showRewardedAd() {
    print('_showRewardedAd ============= yey');
    if (_rewardedAd == null) {
      print('Warning: attempt to show rewarded before loaded.');
      return;
    }
    _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createRewardedAd();
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createRewardedAd();
      },
    );

    _rewardedAd!.setImmersiveMode(true);
    _rewardedAd!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
      print('$ad with reward $RewardItem(${reward.amount}, ${reward.type})');
    });
    _rewardedAd = null;
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
                        // border:
                        //     Border.all(color: Colors.grey.shade300, width: 1),
                        color: Colors.grey.shade100,
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 50.0),
                        child: Column(
                          children: [
                            allKnownWordsCounter == -1
                                ? const CircularProgressIndicator(
                                    color: Colors.black)
                                : Text('$allKnownWordsCounter',
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 80.0,
                                        fontWeight: FontWeight.bold)),
                            Text(settings_page_totalwords[_language]!,
                                // "Your total word count",
                                style: const TextStyle(
                                    color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 18.0)),
                            Text(
                                "CEFR ${getCEFRLevel(allKnownWordsCounter)} ${settings_page_level[_language]}",
                                // "Your total word count",
                                style: const TextStyle(
                                    color: Colors.black54, fontSize: 18.0)),
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
                              color: Colors.grey.shade100,
                              // border: Border.all(
                              //     color: Colors.grey.shade300, width: 1),
                              // color: Colors.grey.shade100,
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
                                  settings_page_derdiedas[_language]!,
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(color: Colors.black54),
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
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(10.0),
                              // border: Border.all(
                              //     color: Colors.grey.shade300, width: 1),
                              // color: Colors.grey.shade300, width: 1),
                              // color: Colors.grey.shade100,
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 20.0),
                            child: Column(
                              children: [
                                Text("$_highScore",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 30.0,
                                        fontWeight: FontWeight.bold)),
                                Text(
                                  settings_page_timetrial[_language]!,
                                  // "High Score",
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(color: Colors.black54),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 0.0),
                    const TitleWSeparator(title: "Spracheinstellungen"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child:
                                Container(child: _languageButton(buttonLanguage: "english"))),
                        // isActive: _language == "english", isEngLangCard: true)),
                        const SizedBox(width: 20.0),
                        Expanded(
                            child:
                                Container(child: _languageButton(buttonLanguage: "hungarian"))),
                        // isActive: _language == "hungarian", isEngLangCard: false)),
                      ],
                    ),
                    SizedBox(height: 0),
                    TitleWSeparator(title: "About Me"),
                    _tempLinkButton(
                        title: "Maximilian",
                        iconData: FontAwesomeIcons.solidUser,
                        iconColor: Colors.black,
                        urlLink: "https://hertelendymm.netlify.app/"),
                    _tempLinkButton(
                        title: "ystystyle.com",
                        iconData: FontAwesomeIcons.link,
                        iconColor: Colors.lightBlue,
                        urlLink: "https://hertelendymm.netlify.app/"),
                    SizedBox(height: 0),
                    TitleWSeparator(title: "Support"),
                    _tempLinkButton(
                      title: "Watch a video ad",
                      iconData: FontAwesomeIcons.circlePlay,
                      iconColor: Colors.orange,
                      urlLink: "",
                      function: () {
                        _showRewardedAd();
                      },
                      // function: (){
                      /// TODO: Ad a RewardedAds here
                      // _showRewardedAd();
                      // }
                    ),
                    _tempLinkButton(
                      title: "BuyMeACoffee/ystystyle",
                      iconData: FontAwesomeIcons.mugSaucer,
                      iconColor: Colors.orange,
                      urlLink: "https://buymeacoffee.com/ystystyle",
                    ),
                    SizedBox(height: 0),
                    TitleWSeparator(title: "More apps"),
                    _tempLinkButton(
                        title: "Ysty Style",
                        iconData: FontAwesomeIcons.android,
                        iconColor: Colors.green,
                        urlLink:
                            "https://play.google.com/store/apps/developer?id=Ysty+Style&hl=hu"),
                    _tempLinkButton(
                        title: "hertelendymm",
                        iconData: FontAwesomeIcons.android,
                        iconColor: Colors.green,
                        urlLink:
                            "https://play.google.com/store/apps/developer?id=hertelendymm&hl=hu"),
                    _tempLinkButton(
                        title: "hertelendymm",
                        iconData: FontAwesomeIcons.apple,
                        iconColor: Colors.grey,
                        urlLink:
                            "https://apps.apple.com/at/developer/marton-maximilian-hertelendy/id1579520614?l=en"),
                    const SizedBox(height: 0.0),
                    TitleWSeparator(title: "Social Media"),
                    _tempLinkButton(
                        title: "Discord",
                        iconData: FontAwesomeIcons.discord,
                        iconColor: Colors.indigo.shade300,
                        urlLink: "https://discord.gg/feK4cj6"),
                    _tempLinkButton(
                        title: "Instagram",
                        iconData: FontAwesomeIcons.instagram,
                        iconColor: Colors.deepOrangeAccent,
                        urlLink: "https://www.instagram.com/ystystyle"),
                    _tempLinkButton(
                        title: "Twitter/X",
                        iconData: FontAwesomeIcons.xTwitter,
                        iconColor: Colors.black,
                        urlLink: "https://x.com/ystystyle"),
                    _tempLinkButton(
                        title: "ProductHunt",
                        iconData: FontAwesomeIcons.productHunt,
                        iconColor: Colors.orange.shade800,
                        urlLink:
                            "https://www.producthunt.com/@hertelendymm/activity"),
                    _tempLinkButton(
                        title: "GitHub",
                        iconData: FontAwesomeIcons.github,
                        iconColor: Colors.black,
                        urlLink: "https://github.com/hertelendymm"),
                    SizedBox(height: 0),
                    TitleWSeparator(title: "Legal notice"),
                    _tempLinkButton(
                      title: "Terms & Conditions",
                      iconData: FontAwesomeIcons.fileContract,
                      iconColor: Colors.grey,
                    ),
                    _tempLinkButton(
                      title: "Privacy Policy",
                      iconData: FontAwesomeIcons.fileContract,
                      iconColor: Colors.grey,
                    ),
                    _tempLinkButton(
                      title: "Icons and images",
                      iconData: FontAwesomeIcons.fileLines,
                      iconColor: Colors.grey,
                    ),
                    const SizedBox(height: 40),
                    Center(child: Text('App version: $appVersionNumberTitle', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),textAlign: TextAlign.center,)),
                    const SizedBox(height: 40),
                    // _tempLinkButton('More apps'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tempLinkButton({
    required String title,
    required IconData iconData,
    required Color iconColor,
    String urlLink = "",
    Function? function,
  }) {
    return GestureDetector(
      onTap: () {
        if (urlLink != "") {
          _launchUrl(url: urlLink);
        }
        if (function != null) {
          function();
          print('hy');
        }
        print('bye');
      },
      child: Container(
          padding: const EdgeInsets.all(20.0),
          margin: const EdgeInsets.symmetric(vertical: 5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.grey.shade300, width: 1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(iconData, color: iconColor, size: 20.0),
                  const SizedBox(width: 20.0),
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 18.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              const Icon(
                FontAwesomeIcons.arrowRight,
                size: 20.0,
              ),
            ],
          )),
    );
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
