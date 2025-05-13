// lib/screens/add_food_popup.dart

import 'package:flutter/material.dart';
import '../models/food_item.dart';


class AddFoodPopup extends StatefulWidget {
  const AddFoodPopup({super.key});

  @override
  State<AddFoodPopup> createState() => _AddFoodPopupState();
}

class _AddFoodPopupState extends State<AddFoodPopup> {
  final _nameController = TextEditingController();
  final _costController = TextEditingController();
  final _quantityController = TextEditingController(text: '1');
  DateTime? _selectedDate;

  void _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add New Food Item'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Food Name'),
            ),
            TextField(
              controller: _costController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Cost'),
            ),
            TextField(
              controller: _quantityController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Quantity'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _pickDate,
              child: Text(
                _selectedDate == null
                    ? 'Pick Expiration Date'
                    : 'Expiration: ${_selectedDate!.toLocal()}'.split(' ')[0],
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close popup
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_nameController.text.isEmpty || _costController.text.isEmpty || _selectedDate == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Please fill out all fields')),
              );
              return;
            }

            final newFoodItem = FoodItem(
              name: _nameController.text,
              expirationDate: _selectedDate!,
              cost: double.tryParse(_costController.text) ?? 0.0,
              quantity: int.tryParse(_quantityController.text) ?? 1,
            );

            Navigator.of(context).pop(newFoodItem);
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}