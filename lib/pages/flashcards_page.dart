import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ysty_style_words/services/category_services.dart';


class FlashcardsPage extends StatefulWidget {
  const FlashcardsPage({super.key, required this.selectedCategory});

  final String selectedCategory;

  @override
  State<FlashcardsPage> createState() => _FlashcardsPageState();
}

class _FlashcardsPageState extends State<FlashcardsPage> {
  String? _selectedCategory;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedCategory = widget.selectedCategory;
    // _checkCategory();
  }

  _checkCategory() async {
    String? categoryName = await CategoryService.loadSelectedCategory();
    if (categoryName != _selectedCategory) {
      _selectedCategory = categoryName;
      await _loadNewGameData();
    }
  }

  _loadNewGameData(){

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
