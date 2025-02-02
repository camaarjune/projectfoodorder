import 'cart_model.dart';

class CartState {
  static List<CartItem> items = [];
  static bool hasItems = false;

  static void addItem(CartItem item) {
    // Check if the item already exists in the cart
    for (var cartItem in items) {
      if (cartItem.name == item.name) {
        cartItem.quantity++; // Increment quantity if item exists
        return;
      }
    }
    items.add(item); // Add new item
    hasItems = true; // Set hasItems to true when an item is added
  }
} 