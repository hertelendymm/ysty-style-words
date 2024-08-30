// import 'package:flutter/material.dart';
//
// class Flashcard extends StatefulWidget {
//   const Flashcard({super.key});
//   int index, bool isCardFlipped;
//
//   @override
//   State<Flashcard> createState() => _FlashcardState();
// }
//
// class _FlashcardState extends State<Flashcard> {
//   @override
//   Widget build(BuildContext context) {
//       return isCardFlipped
//           ? GestureDetector(
//         onTap: (){
//           setState(() {
//             isCardFlipped = false;
//             print("click");
//           });
//         },
//         child: Container(
//           // padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 100.0),
//           // margin: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 20.0),
//           width: MediaQuery.sizeOf(context).width,
//           // height: 500.0,
//           // width: MediaQuery.sizeOf(context).width * 0.75,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(20.0),
//             border: Border.all(color: Colors.grey.shade900, width: 3),
//             color: Colors.white,
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(wordData[index].article,
//                   style: const TextStyle(
//                       fontWeight: FontWeight.normal,
//                       fontSize: 20.0,
//                       color: Colors.black)),
//               const SizedBox(height: 40.0),
//               Text(wordData[index].germanWord,
//                   style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: wordData[index].germanWord.length > 8
//                           ? 30.0
//                           : 50.0,
//                       color: Colors.black)),
//               const SizedBox(height: 40.0),
//               Text(
//                 wordData[index].exampleSentence,
//                 style: const TextStyle(
//                     fontWeight: FontWeight.normal,
//                     fontSize: 20.0,
//                     color: Colors.grey),
//                 textAlign: TextAlign.center,
//               ),
//             ],
//           ),
//         ),
//       )
//           : GestureDetector(
//         onTap: (){
//           setState(() {
//             isCardFlipped = true;
//             print("click");
//           });
//         },
//         child: Container(
//           // padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 100.0),
//           // margin: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 20.0),
//           width: MediaQuery.sizeOf(context).width,
//           // height: 500.0,
//           // width: MediaQuery.sizeOf(context).width * 0.75,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(20.0),
//             border: Border.all(color: Colors.grey.shade900, width: 3),
//             color: Colors.black,
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(wordData[index].article,
//                   style: const TextStyle(
//                       fontWeight: FontWeight.normal,
//                       fontSize: 20.0,
//                       color: Colors.white)),
//               const SizedBox(height: 40.0),
//               Text(wordData[index].germanWord,
//                   style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: wordData[index].germanWord.length > 8
//                           ? 30.0
//                           : 50.0,
//                       color: Colors.white)),
//               const SizedBox(height: 40.0),
//               Text(
//                 wordData[index].exampleSentence,
//                 style: const TextStyle(
//                     fontWeight: FontWeight.normal,
//                     fontSize: 20.0,
//                     color: Colors.grey),
//                 textAlign: TextAlign.center,
//               ),
//             ],
//           ),
//         ),
//       );
//     }
// }
