import 'package:flutter/material.dart';
import 'package:ysty_style_words/constants.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ysty_style_words/widgets/appbar_secondary.dart';
import 'package:ysty_style_words/widgets/title_w_sparator.dart';

class DerDieDasHelpPage extends StatelessWidget {
  const DerDieDasHelpPage({super.key, required this.language});

  final String language;

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
                children: [
                  Text(
                    derdiedas_help_page_def[language]!, style: TextStyle(fontSize: 16.0),),
                  SizedBox(
                    height: 20.0,
                  ),
                  TitleWSeparator(title: derdiedas_help_page_title1[language]!),
                  Text(
                    derdiedas_help_page_tipp1[language]!, style: TextStyle(fontSize: 16.0),),
                  SizedBox(
                    height: 20.0,
                  ),
                  TitleWSeparator(title: derdiedas_help_page_title2[language]!),
                  Text(derdiedas_help_page_tipp2[language]!, style: TextStyle(fontSize: 16.0),),
                  SizedBox(
                    height: 20.0,
                  ),
                  TitleWSeparator(title: derdiedas_help_page_title3[language]!),
                  Text(derdiedas_help_page_tipp3[language]!, style: TextStyle(fontSize: 16.0),),
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
