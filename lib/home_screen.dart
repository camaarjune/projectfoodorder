import 'package:flutter/material.dart';
import 'OrdersScreen.dart';
import 'OrderDetailScreen.dart';
import 'cart_screen.dart';
import 'cart_state.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        elevation: 0,
        title: Text('Home'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Special Offers',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderDetailScreen(
                      imagePath: 'lib/assets/images/specialBurger.png',
                      name: 'Special Offer Burger',
                      price: 10.00, // Example price
                      description: 'Delicious Special Offer Burger with rich flavor.',
                    ),
                  ),
                );
              },
              child: Container(
                width: double.infinity,
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: AssetImage('lib/assets/images/specialBurger.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                  child: Text(
                    'Special Offer Burger',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      backgroundColor: Colors.black54,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Get Coffee And Tea',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => OrdersScreen()),
                      );
                    },
                    child: Text('See All'),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CoffeeItem(
                        imagePath: 'lib/assets/images/machittao.png',
                        name: 'Macchiato',
                        price: 4.40,
                        rating: 4.9,
                      ),
                      CoffeeItem(
                        imagePath: 'lib/assets/images/flatWhite.png',
                        name: 'Flat White',
                        price: 4.50,
                        rating: 4.9,
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CoffeeItem(
                        imagePath: 'lib/assets/images/capuccino.png',
                        name: 'Cappuccino',
                        price: 4.20,
                        rating: 4.8,
                      ),
                      CoffeeItem(
                        imagePath: 'lib/assets/images/espresso.png',
                        name: 'Espresso',
                        price: 3.80,
                        rating: 4.7,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Fast Foods',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => OrdersScreen()),
                      );
                    },
                    child: Text('See All'),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CoffeeItem(
                        imagePath: 'lib/assets/images/burger.png',
                        name: 'Burger',
                        price: 5.50,
                        rating: 4.6,
                      ),
                      CoffeeItem(
                        imagePath: 'lib/assets/images/fries.png',
                        name: 'Fries',
                        price: 3.00,
                        rating: 4.5,
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CoffeeItem(
                        imagePath: 'lib/assets/images/hotDog.png',
                        name: 'Hot Dog',
                        price: 4.00,
                        rating: 4.4,
                      ),
                      CoffeeItem(
                        imagePath: 'lib/assets/images/pizzaSlice.png',
                        name: 'Pizza Slice',
                        price: 3.50,
                        rating: 4.6,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.brown,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home, color: Colors.white),
              onPressed: () {
                // Navigate to Home
              },
            ),
            IconButton(
              icon: Icon(Icons.shopping_bag, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OrdersScreen()),
                );
              },
            ),
            Stack(
              children: [
                IconButton(
                  icon: Icon(Icons.shopping_cart, color: Colors.white),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CartScreen()),
                    );
                    // Clear the notification dot
                    setState(() {
                      CartState.hasItems = false;
                    });
                  },
                ),
                if (CartState.hasItems)
                  Positioned(
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      constraints: BoxConstraints(
                        minWidth: 12,
                        minHeight: 12,
                      ),
                    ),
                  ),
              ],
            ),
            IconButton(
              icon: Icon(Icons.settings, color: Colors.white),
              onPressed: () async {
                // Navigate to Settings
                final name = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SettingsScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CoffeeItem extends StatelessWidget {
  final String imagePath;
  final String name;
  final double price;
  final double rating;

  const CoffeeItem({
    required this.imagePath,
    required this.name,
    required this.price,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OrderDetailScreen(
              imagePath: imagePath,
              name: name,
              price: price,
              description: 'Delicious $name with rich flavor.',
            ),
          ),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 2.2,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.asset(
                imagePath,
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.orange, size: 16),
                          SizedBox(width: 4),
                          Text(rating.toString()),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Text('\$${price.toStringAsFixed(2)}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}