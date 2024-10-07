import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ysty_style_words/widgets/appbar_secondary.dart';
import 'package:ysty_style_words/widgets/title_w_sparator.dart';

class DerDieDasHelpPage extends StatelessWidget {
  const DerDieDasHelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // _myAppBar(context),
            AppBarSecondary(onPressed: ()=> Navigator.pop(context), title: 'Help'),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(20.0),
                /// padding: const EdgeInsets.all(40.0), <-- The bigger padding looks better
                children: const [
                  Text(
                      "German, unlike English, has grammatical gender for nouns. This means that each noun is classified as masculine, feminine, or neuter. Unfortunately, there's no hard-and-fast rule for determining a noun's gender. However, here are some general guidelines and tips:", style: TextStyle(fontSize: 16.0),),
                  SizedBox(
                    height: 20.0,
                  ),
                  TitleWSeparator(title: 'Common Gender Endings'),
                  Text("While not foolproof, certain word endings can often indicate gender:\n\n • Masculine: -er, -el, -or, -ling (e.g., der Vater - father, der Apfel - apple), Automarken, \"Kalendar\", \"Wetter\", Alkoholsorten\n • Feminine: -ung, -heit, -keit, -schaft (e.g., die Zeitung - newspaper, die Freiheit - freedom)\n • Neuter: -chen, -lein, -tum (e.g., das Mädchen - girl, das Häuschen - little house), Chemische Elemente", style: TextStyle(fontSize: 16.0),),
                  SizedBox(
                    height: 20.0,
                  ),
                  TitleWSeparator(title: 'Noun Pairs'),
                  Text("Some nouns have gendered pairs:\n\n • Masculine and Feminine: der Mann (man) - die Frau (woman), der Junge (boy) - das Mädchen (girl)\n • Masculine and Neuter: der Tag (day) - das Jahr (year), der Berg (mountain) - das Tal (valley)", style: TextStyle(fontSize: 16.0),),
                  SizedBox(
                    height: 20.0,
                  ),
                  TitleWSeparator(title: 'Cognates'),
                  Text("If a German noun is a cognate with an English word, the gender often matches:\n\n • Masculine: der Vater (father), der Bruder (brother), der Garten (garden)\n • Feminine: die Mutter (mother), die Schwester (sister), die Küche (kitchen)\n • Neuter: das Haus (house), das Buch (book), das Auto (car)", style: TextStyle(fontSize: 16.0),),
                  SizedBox(
                    height: 20.0,
                  ),
                  TitleWSeparator(title: 'Practice and Exposure'),
                  Text("The best way to learn German word genders is through consistent practice and exposure to the language. Read books, watch movies, and listen to music in German to familiarize yourself with the patterns and exceptions.", style: TextStyle(fontSize: 16.0),),
                  SizedBox(
                    height: 20.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget _myAppBar(context){
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
  //                 onTap: () {
  //                   Navigator.pop(context);
  //                 },
  //                 child: Container(
  //                   // color: Colors.red,
  //                   padding:
  //                   const EdgeInsets.symmetric(vertical: 0.0),
  //                   // const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
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
  //                   // height: 40.0,
  //                   padding: const EdgeInsets.symmetric(
  //                       horizontal: 0.0, vertical: 6.0),
  //                   child: const Center(
  //                       child: Text(
  //                         "Der/Die/Das Help",
  //                         style: TextStyle(
  //                             fontWeight: FontWeight.bold, fontSize: 24.0),
  //                         textAlign: TextAlign.center,
  //                       )),
  //                 ),
  //               ),
  //               const SizedBox(width: 45.0),
  //             ],
  //           ),
  //         ),
  //         const SizedBox(height: 20.0),
  //         Container(
  //           color: Colors.grey.shade200,
  //           height: 2.0,
  //         ),
  //       ],
  //     ),
  //   );
  // }


}
