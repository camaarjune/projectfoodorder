import 'package:flutter/material.dart';
import 'cart_model.dart';
import 'cart_state.dart';

class OrderDetailScreen extends StatefulWidget {
  final String imagePath;
  final String name;
  final double price;
  final String description;

  const OrderDetailScreen({
    required this.imagePath,
    required this.name,
    required this.price,
    required this.description,
  });

  @override
  _OrderDetailScreenState createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  int _quantity = 1;
  List<CartItem> cartItems = []; // Cart items list

  void _increment() {
    setState(() {
      _quantity++;
    });
  }

  void _decrement() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  void _addToCart() {
    final newItem = CartItem(
      name: widget.name,
      price: widget.price,
      imagePath: widget.imagePath,
      quantity: _quantity,
    );

    // Add item to CartState
    CartState.addItem(newItem);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${widget.name} added to cart!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice = widget.price * _quantity;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              widget.imagePath,
              fit: BoxFit.cover,
              height: 250,
              width: double.infinity,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '\$${widget.price.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 20, color: Colors.orange),
                  ),
                  SizedBox(height: 16),
                  Text(
                    widget.description,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: _decrement,
                          ),
                          Text('$_quantity', style: TextStyle(fontSize: 20)),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: _increment,
                          ),
                        ],
                      ),
                      Text(
                        'Total: \$${totalPrice.toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Center(
                    child: TextButton.icon(
                      icon: Icon(Icons.shopping_cart, color: Colors.black),
                      label: Text('Add to Cart', style: TextStyle(color: Colors.black)),
                      onPressed: () {
                        _addToCart();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
} 