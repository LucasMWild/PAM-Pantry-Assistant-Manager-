import 'food_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class PantryList {
  static final PantryList _instance = PantryList._internal();
  bool _loadedFromPrefs = false; // <-- track if we've loaded already

  factory PantryList() {
    return _instance;
  }

  PantryList._internal();

  final List<FoodItem> _items = [];

  List<FoodItem> get items => _items;

  Future<void> ensureLoaded() async {
    if (!_loadedFromPrefs) {
      await loadFromPrefs();
    }
  }

  Future<void> addItem(FoodItem item) async {
    _items.add(item);
    await _saveToPrefs();
  }

  Future<void> removeItem(FoodItem item) async {
    _items.remove(item);
    await _saveToPrefs();
  }

  Future<void> save() async {
    await _saveToPrefs();
  }

  Future<void> _saveToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> foodJsonList = _items.map((item) => json.encode({
      'name': item.name,
      'expirationDate': item.expirationDate.toIso8601String(),
      'cost': item.cost,
    })).toList();
    await prefs.setStringList('pantryList', foodJsonList);
  }

  Future<void> loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? foodJsonList = prefs.getStringList('pantryList');
    if (foodJsonList != null) {
      _items.clear();
      _items.addAll(foodJsonList.map((itemJson) {
        Map<String, dynamic> jsonMap = json.decode(itemJson);
        return FoodItem(
          name: jsonMap['name'],
          expirationDate: DateTime.parse(jsonMap['expirationDate']),
          cost: (jsonMap['cost'] as num).toDouble(),
        );
      }).toList());
    }
    _loadedFromPrefs = true;
  }
}
