import 'package:flutter/material.dart';
import 'pantry_screen.dart';
import '../popups/add_food_popup.dart';
import '../constants.dart';
import '../models/pantry_list.dart';
import '../models/food_item.dart';



class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: appBackgroundColor,
      appBar: AppBar
      (
        title: const Text("Food Expiration Tracker"),
        backgroundColor: appBackgroundColor,
      ),
      
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Welcome!", style: TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PantryScreen()),
                );
              },
              icon: const Icon(Icons.fastfood),
              label: const Text("View Tracked Food"),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () async {
                final result = await showDialog<FoodItem>(
                  context: context,
                  builder: (BuildContext context) {
                    return const AddFoodPopup();
                  },
                );

                if (result != null) {
                  // Add to the PantryList singleton
                  final pantryList = PantryList(); // singleton
                  await pantryList.addItem(result); // use await because addItem saves
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Food item added!')),
                  );
                }
              },
              icon: const Icon(Icons.add),
              label: const Text("Add New Food Item"),
            ),
          ],
        ),
      ),
    );
  }
}