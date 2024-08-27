import 'package:flutter/material.dart';
import 'package:ysty_style_words/pages/derdiedas_help_page.dart';
import 'package:ysty_style_words/services/category_services.dart';
import 'package:ysty_style_words/widgets/button_rounded.dart';


class DerDieDasPage extends StatefulWidget {
  const DerDieDasPage({super.key});
  // const DerDieDasPage({super.key, required this.selectedCategory});

  // final String selectedCategory;

  @override
  State<DerDieDasPage> createState() => _DerDieDasPageState();
}

class _DerDieDasPageState extends State<DerDieDasPage> {

  String _selectedCategory = 'Select a category';

  // getSelectedCategory() async {
  //   String? selectedCategory = await CategoryService.loadSelectedCategory();
  //   if (selectedCategory != null) {
  //     setState(() {
  //       _selectedCategory = _selectedCategory;
  //     });
  //   }
  // }


  getSelectedCategory(){
    CategoryService.loadSelectedCategory().then((categoryName) {
      if (categoryName != null) {
        // Use the categoryName to load relevant content
        setState(() {
          _selectedCategory = categoryName;
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSelectedCategory();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: MainAppBar(),
      // appBar: MainAppBar(selectedCategory: _selectedCategory),
      // appBar: const MainAppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 80.0),
                margin: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(color: Colors.grey.shade300, width: 3),
                    color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('________',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 40.0)),
                    Text('Krankenwagen',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 40.0)),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                      child: ButtonRounded(
                    text: "der",
                    onPressed: () {},
                  )),
                  SizedBox(width: 20.0),
                  Expanded(child: ButtonRounded(text: "die", onPressed: () {})),
                  SizedBox(width: 20.0),
                  Expanded(child: ButtonRounded(text: "das", onPressed: () {})),
                ],
              ),
              ButtonRounded(text: "Help", backgroundColor: Colors.grey.shade200, textColor: Colors.black, onPressed: ()=>Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DerDieDasHelpPage()))),
            ],
          ),
        ),
      ),
    );
  }
}
