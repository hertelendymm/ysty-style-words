import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'categories_page.dart';

class MatchingPage extends StatefulWidget {
  const MatchingPage({super.key});

  @override
  State<MatchingPage> createState() => _MatchingPageState();
}

class _MatchingPageState extends State<MatchingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
                onTap: (){},
                child: const Icon(FontAwesomeIcons.user)
            ),
            const SizedBox(width: 10.0,),
            Expanded(
              child: GestureDetector(
                onTap: (){Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CategoriesPage()),);
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
            const SizedBox(width: 35.0,),
            // GestureDetector(
            //     onTap: (){},
            //     child: const Icon(FontAwesomeIcons.gear)
            // ),
          ],
        ),
        // centerTitle: true,
      ),
      body: Container(color: Colors.green,),
    );
  }
}
