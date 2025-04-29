import 'package:flutter/material.dart';
import 'pantry_screen.dart';
import '../popups/add_food_popup.dart';
import '../constants.dart';



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
            ElevatedButton.icon
            (
              onPressed: () 
              {

                showDialog
                (
                  context: context,
                  builder: (BuildContext context) 
                  {
                    return const AddFoodPopup();
                  },
                );
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