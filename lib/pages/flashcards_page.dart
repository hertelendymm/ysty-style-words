import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ysty_style_words/services/category_services.dart';


class FlashcardsPage extends StatefulWidget {
  // const FlashcardsPage({super.key});
  const FlashcardsPage({super.key, required this.selectedCategory});

  final String selectedCategory;

  @override
  State<FlashcardsPage> createState() => _FlashcardsPageState();
}

class _FlashcardsPageState extends State<FlashcardsPage> {

  // String _selectedCategory = 'Animal';
  //
  // Future<String?> loadSelectedCategory() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.getString('selectedCategory');
  // }
  //
  // @override
  // void initState() {
  //   super.initState();
  //   loadSelectedCategory().then((categoryName) {
  //     if (categoryName != null) {
  //       setState(() {
  //         _selectedCategory = categoryName;
  //       });
  //     }
  //   });
  // }

  // String _selectedCategory = 'Select a category';
  String? _selectedCategory;

  // getSelectedCategory() async {
  //   String? selectedCategory = await CategoryService.loadSelectedCategory();
  //   if (selectedCategory != null) {
  //     setState(() {
  //       _selectedCategory = _selectedCategory;
  //     });
  //   }
  // }

  // getSelectedCategory(){
  //   CategoryService.loadSelectedCategory().then((categoryName) {
  //     if (categoryName != null) {
  //       // Use the categoryName to load relevant content
  //       setState(() {
  //         _selectedCategory = categoryName;
  //       });
  //     }
  //   });
  // }

  Future<void> _loadSelectedCategory() async {
    String? categoryName = await CategoryService.loadSelectedCategory();
    setState(() {
      _selectedCategory = categoryName;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      // getSelectedCategory();
    _loadSelectedCategory();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: MainAppBar(),
      // appBar: MainAppBar(selectedCategory: _selectedCategory ?? 'Select a category',),
      // appBar: MainAppBar(selectedCategory: _selectedCategory),
      // appBar: MainAppBar(selectedCategory: widget.selectedCategory),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 0.0),
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 100.0),
                    margin: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 20.0),
                    width: MediaQuery.sizeOf(context).width*0.75,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.black),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('der',
                            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20.0, color: Colors.white)),
                        SizedBox(height: 40.0),
                        Text('Frühling',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50.0, color: Colors.white)),
                        SizedBox(height: 40.0),
                        Text('Im Frühling blühen die Blumen.',
                            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20.0, color: Colors.grey), textAlign: TextAlign.center,),
                      ],
                    ),
                  ),
                  Text('Tap to flip',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.grey.shade300), textAlign: TextAlign.center,),
                ],
              ),
        
              // const Text('Swipe right if you know it, swipe left if you need more practice and tap the card to see the other side',
              //     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0), textAlign: TextAlign.center,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Icon(FontAwesomeIcons.xmark, color: Colors.red, size: 40.0),
                  Icon(FontAwesomeIcons.arrowLeftLong, color: Colors.grey.shade300, size: 40.0),
                  const Text("Swipe",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.grey)),
                  Icon(FontAwesomeIcons.arrowRightLong, color: Colors.grey.shade300, size: 40.0),
                  const Icon(FontAwesomeIcons.check, color: Colors.green, size: 40.0),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
