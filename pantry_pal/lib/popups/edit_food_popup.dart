import 'package:flutter/material.dart';
import '../models/food_item.dart';

class EditFoodPopup extends StatefulWidget {
  final FoodItem foodItem;

  const EditFoodPopup({super.key, required this.foodItem});

  @override
  State<EditFoodPopup> createState() => _EditFoodPopupState();
}

class _EditFoodPopupState extends State<EditFoodPopup> {
  late TextEditingController _nameController;
  late TextEditingController _costController;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.foodItem.name);
    _costController = TextEditingController(text: widget.foodItem.cost.toString());
    _selectedDate = widget.foodItem.expirationDate;
  }

  void _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
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
      title: const Text('Edit Food Item'),
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
            if (_nameController.text.isEmpty ||
                _costController.text.isEmpty ||
                _selectedDate == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Please fill out all fields')),
              );
              return;
            }

            final updatedFoodItem = FoodItem(
              name: _nameController.text,
              expirationDate: _selectedDate!,
              cost: double.tryParse(_costController.text) ?? 0.0,
            );

            Navigator.of(context).pop(updatedFoodItem);
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
