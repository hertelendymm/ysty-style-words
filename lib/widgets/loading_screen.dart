import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: 800, child: Center(child: CircularProgressIndicator()));
  }
}
