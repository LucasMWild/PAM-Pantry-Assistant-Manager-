import 'package:flutter/material.dart';
import 'food_list_screen.dart';
import 'add_food_popup.dart';



class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar
      (
        title: const Text("Food Expiration Tracker"),
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
                  MaterialPageRoute(builder: (context) => FoodListScreen()),
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