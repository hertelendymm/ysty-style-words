import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ysty_style_words/pages/categories_page.dart';

class MainAppBar extends StatelessWidget {
  const MainAppBar({
    super.key,
    required this.leftIcon,
    required this.onPressedLeftIcon,
    required this.rightIcon,
    required this.onPressedRightIcon,
    this.isCategoryButtonClickable = true
  });

  final Widget leftIcon;
  final Function onPressedLeftIcon;
  final Widget rightIcon;
  final Function onPressedRightIcon;
  final bool isCategoryButtonClickable;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: onPressedLeftIcon(),
            child: leftIcon
          ),
          const SizedBox(width: 10.0,),
          Expanded(
            child: GestureDetector(
              onTap: isCategoryButtonClickable ? (){Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CategoriesPage()),
                );}:(){
                ///do nothing if isCategoryButtonClickable == false
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(color: Colors.grey, width: 3),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: const Text("Category", style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
              ),
            ),
          ),
          const SizedBox(width: 10.0,),
          GestureDetector(
              onTap: onPressedRightIcon(),
              child: rightIcon
          ),
        ],
      ),
      // centerTitle: true,
    );
  }
}
