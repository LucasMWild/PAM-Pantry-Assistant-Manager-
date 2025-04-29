import 'package:flutter/material.dart';
import 'package:pantry_pal/constants.dart';
import '../models/pantry_list.dart'; // Import PantryList
import '../models/food_item.dart';   // Import FoodItem
import '../popups/edit_food_popup.dart';
import '../popups/add_food_popup.dart'; // Import your AddFoodPopup

class PantryScreen extends StatefulWidget {
  const PantryScreen({super.key});

  @override
  State<PantryScreen> createState() => _PantryScreenState();
}

class _PantryScreenState extends State<PantryScreen> {
  final PantryList pantryList = PantryList(); // PantryList instance

  @override
  void initState() {
    super.initState();
    pantryList.loadFromPrefs().then((_) {
      setState(() {}); // <-- important to refresh UI after loading
    });
  }

  void _openAddFoodPopup() async {
    final result = await showDialog<FoodItem>(
      context: context,
      builder: (context) => const AddFoodPopup(),
    );

    if (result != null) {
      setState(() {
        pantryList.addItem(result);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final items = pantryList.items;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Tracked Food Items"),
        backgroundColor: appBackgroundColor,
        elevation: 0, // optional: removes the shadow under the AppBar
      ),
      backgroundColor: appBackgroundColor,
      body: items.isEmpty
    ? const Center(
        child: Text("No food items yet!"),
      )
    : ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final food = items[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            elevation: 3, // small shadow
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // rounded corners
            ),
            child: ListTile(
              title: Text(food.name),
              subtitle: Text(
                "Expires: ${food.expirationDate.toLocal().toString().split(' ')[0]} | Cost: \$${food.cost.toStringAsFixed(2)}",
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                color: Colors.red,
                onPressed: () {
                  setState(() {
                    pantryList.removeItem(food);
                  });
                },
              ),
              onTap: () async {
                final editedItem = await showDialog<FoodItem>(
                  context: context,
                  builder: (context) => EditFoodPopup(foodItem: food),
                );

                if (editedItem != null) {
                  setState(() {
                    // Update the item at that index
                    pantryList.items[index] = editedItem;
                    pantryList.save(); // save to SharedPreferences again
                  });
                }
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddFoodPopup,
        child: const Icon(Icons.add),
      ),
    );
  }
}
