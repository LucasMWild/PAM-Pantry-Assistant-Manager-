import 'package:flutter/material.dart';

class FoodListScreen extends StatelessWidget {
  const FoodListScreen({super.key}); // 👈 add key to constructor

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