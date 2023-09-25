import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final Widget content;
  final Widget bottomNavigationBar;
  const HomeScreen({
    super.key,
    required this.content,
    required this.bottomNavigationBar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: content,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
