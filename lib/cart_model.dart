class CartItem {
  final String name;
  final double price;
  final String imagePath;
  int quantity;
  bool isOrdered;

  CartItem({
    required this.name,
    required this.price,
    required this.imagePath,
    this.quantity = 1,
    this.isOrdered = false,
  });
} 