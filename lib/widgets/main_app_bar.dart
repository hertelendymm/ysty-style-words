// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:ysty_style_words/pages/categories_page.dart';
// import 'package:ysty_style_words/pages/settings_page.dart';
// import 'package:ysty_style_words/services/categoryServices.dart';
//
//
// class MainAppBar extends StatefulWidget implements PreferredSizeWidget{
//   const MainAppBar({super.key});
//
//   @override
//   State<MainAppBar> createState() => _MainAppBarState();
//
//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight+12);
// }
//
// class _MainAppBarState extends State<MainAppBar> {
//   // String? _selectedCategory;
//   //
//   // Future<void> _loadSelectedCategory() async {
//   //   String? categoryName = await CategoryService.loadSelectedCategory();
//   //   setState(() {
//   //     _selectedCategory = categoryName;
//   //   });
//   // }
//   //
//   // @override
//   // void initState() {
//   //   // TODO: implement initState
//   //   super.initState();
//   //   // getSelectedCategory();
//   //   _loadSelectedCategory();
//   // }
//
//   String? _selectedCategory;
//   bool _isLoading = true; // Add a loading state
//
//   @override
//   void initState() {
//     super.initState();
//     _loadSelectedCategory();
//   }
//
//   Future<void> _loadSelectedCategory() async {
//     String? categoryName = await CategoryService.loadSelectedCategory();
//     setState(() {
//       _selectedCategory = categoryName;
//       _isLoading = false; // Update loading state after data is loaded
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         SizedBox(
//           height: kToolbarHeight + 12,
//           child: AppBar(
//             backgroundColor: Colors.white,
//             title: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Expanded(
//                   child: GestureDetector(
//                     onTap: () => Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => const CategoriesPage())),
//                     child: Container(
//                       // height: 40.0,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(20.0),
//                         border: Border.all(color: Colors.grey.shade300, width: 3),
//                       ),
//                       padding:
//                           const EdgeInsets.symmetric(horizontal: 0.0, vertical: 6.0),
//                       // padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                       child:  Center(
//                           child: Text(_isLoading ? "" : _selectedCategory??"Select a Category",
//                         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
//                         textAlign: TextAlign.center,
//                       )),
//
//
//                       /// TODO: From SharedPreference load the lest chosen category title!!!
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   width: 10.0,
//                 ),
//                 GestureDetector(
//                   onTap: () => Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => const SettingsPage())),
//                   child: Container(
//                     // color: Colors.red,
//                     padding:
//                     const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
//                         // const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
//                     child: Container(
//                       padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(25.0),
//                           color: Colors.grey.shade200),
//                       child: const Icon(FontAwesomeIcons.gear, color: Colors.black),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         Container(
//           color: Colors.grey.shade200,
//           height: 2.0,
//         ),
//       ],
//     );
//   }
//
//   // @override
//   // Size get preferredSize => const Size.fromHeight(kToolbarHeight+12);
// }
