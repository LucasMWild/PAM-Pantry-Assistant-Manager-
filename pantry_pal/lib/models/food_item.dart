class FoodItem {
  final String name;
  final DateTime expirationDate;
  final double cost;
  int quantity;

  FoodItem({
    required this.name,
    required this.expirationDate,
    required this.cost,
    this.quantity = 1,
  });
}