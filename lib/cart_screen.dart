import 'package:flutter/material.dart';
import 'cart_model.dart';
import 'cart_state.dart';

class CartScreen extends StatelessWidget {
  final double deliveryFee = 1.50; // Delivery fee

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: CartState.items.isEmpty
          ? Center(
              child: Text(
                'Your cart is empty.',
                style: TextStyle(fontSize: 24),
              ),
            )
          : ListView.builder(
              itemCount: CartState.items.length,
              itemBuilder: (context, index) {
                final item = CartState.items[index];
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Image.asset(item.imagePath, width: 100, height: 100),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            SizedBox(height: 8),
                            Text('\$${item.price.toStringAsFixed(2)}', style: TextStyle(fontSize: 16)),
                            SizedBox(height: 8),
                            Text('Quantity: ${item.quantity}', style: TextStyle(fontSize: 16)),
                            if (item.isOrdered)
                              Text('Ordered', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold))
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.remove_circle, color: Colors.red),
                        onPressed: () {
                          _confirmRemove(context, item);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.info, color: Colors.blue),
                        onPressed: () {
                          _showItemDetails(context, item);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Delivery Fee:', style: TextStyle(fontSize: 16)),
                Text('\$${deliveryFee.toStringAsFixed(2)}', style: TextStyle(fontSize: 16)),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total Amount:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text('\$${_calculateTotal().toStringAsFixed(2)}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Handle checkout logic here
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Proceeding to checkout...')),
                );

                // Show order placed message
                Future.delayed(Duration(seconds: 1), () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Your order has been placed! It will be delivered soon.')),
                  );
                });
              },
              child: Text('Checkout'),
            ),
          ],
        ),
      ),
    );
  }

  double _calculateTotal() {
    // Calculate total only for ordered items
    double total = CartState.items
        .where((item) => item.isOrdered) // Filter for ordered items
        .fold(0, (sum, item) => sum + (item.price * item.quantity));
    return total + deliveryFee; // Add delivery fee to total
  }

  void _confirmRemove(BuildContext context, CartItem item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Remove Item'),
          content: Text('Are you sure you want to remove ${item.name} from the cart?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                CartState.items.remove(item); // Remove the item from the cart
                if (CartState.items.isEmpty) {
                  CartState.hasItems = false; // Update hasItems if cart is empty
                }
                Navigator.of(context).pop(); // Close the dialog
                // Optionally, show a snackbar or toast
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${item.name} removed from cart!')),
                );
              },
              child: Text('Remove'),
            ),
          ],
        );
      },
    );
  }

  void _showItemDetails(BuildContext context, CartItem item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(item.name),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(item.imagePath, width: 100, height: 100),
              SizedBox(height: 8),
              Text('Price: \$${item.price.toStringAsFixed(2)}'),
              SizedBox(height: 8),
              Text('Quantity: ${item.quantity}'),
              SizedBox(height: 8),
              Text('Description: Delicious ${item.name} with rich flavor.'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (!item.isOrdered) {
                  item.isOrdered = true; // Mark the item as ordered
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${item.name} has been ordered!')),
                  );
                }
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Order Now'),
            ),
            TextButton(
              onPressed: () {
                _confirmCancelOrder(context, item); // Call the cancel order confirmation
              },
              child: Text('Cancel Order'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _confirmCancelOrder(BuildContext context, CartItem item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Cancel Order'),
          content: Text('Are you sure you want to cancel the order for ${item.name}?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                item.isOrdered = false; // Mark the item as not ordered
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Order for ${item.name} has been canceled.')),
                );
                Navigator.of(context).pop(); // Close the dialog
                Navigator.of(context).pop(); // Close the item details dialog
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }
} 