import 'package:flutter/material.dart';

class PantryScreen extends StatelessWidget {
  const PantryScreen({super.key}); // 👈 add key to constructor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tracked Food Items"),
      ),
      body: const Center(
        child: Text("No food items yet!"),
      ),
    );
  }
}