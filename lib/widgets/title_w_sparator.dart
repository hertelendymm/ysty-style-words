import 'package:flutter/material.dart';
class TitleWSeparator extends StatelessWidget {
  const TitleWSeparator({
    super.key,
    this.title="--",
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold)),
          Container(
            width: double.infinity,
            height: 5,
            color: Colors.black,
          )
        ],
      ),
    );
  }
}
