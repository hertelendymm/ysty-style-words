import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ysty_style_words/pages/categories_page.dart';
import 'package:ysty_style_words/pages/settings_page.dart';
import 'package:ysty_style_words/services/category_services.dart';

class MainAppBar extends StatefulWidget {
  const MainAppBar({super.key, required this.updateParent, required this.selectedCategory});

  final VoidCallback updateParent;
  final String selectedCategory;

  @override
  State<MainAppBar> createState() => _MainAppBarState();
}

class _MainAppBarState extends State<MainAppBar> {
  String? _selectedCategory = 'Loading';
  // bool _isLoading = true;

  // Future<void> _loadSelectedCategory() async {
  //   String? categoryName = await CategoryService.loadSelectedCategory();
  //   setState(() {
  //     _selectedCategory = categoryName;
  //     _isLoading = false; // Update loading state after data is loaded
  //   });
  // }

  _checkCategory() async {
    String? categoryName = await CategoryService.loadSelectedCategory();
    if (categoryName != widget.selectedCategory) {
      setState(() {
        _selectedCategory = categoryName;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _checkCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
            children: [
              Container(
                height: kToolbarHeight + 12,
                margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CategoriesPage(onRefresh: (){
                                      widget.updateParent();
                                      _checkCategory();
                                    }))),
                        child: Container(
                          // height: 40.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40.0),
                            border: Border.all(color: Colors.grey.shade300, width: 3),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0.0, vertical: 6.0),
                          margin: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 12.0),
                          // padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Center(
                              child: Text(_selectedCategory!,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20.0),
                            textAlign: TextAlign.center,
                          )),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SettingsPage())),
                      child: Container(
                        // color: Colors.red,
                        padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                        // const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.0),
                              color: Colors.grey.shade200),
                          child:
                              const Icon(FontAwesomeIcons.gear, color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.grey.shade200,
                height: 2.0,
              ),
            ],
          );
  }
}
