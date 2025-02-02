import 'package:flutter/material.dart';

import 'OrderDetailScreen.dart';

class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  String _searchQuery = "";
  String _filter = "all";

  final List<Map<String, String>> _items = [
    {'type': 'food', 'title': 'Burger', 'image': 'lib/assets/images/burger.png'},
    {'type': 'food', 'title': 'Pizza', 'image': 'lib/assets/images/pizzaSlice.png'},
    {'type': 'food', 'title': 'Fries', 'image': 'lib/assets/images/fries.png'},
    {'type': 'food', 'title': 'Hot Dog', 'image': 'lib/assets/images/hotDog.png'},
    {'type': 'food', 'title': 'Pasta', 'image': 'lib/assets/images/pasta.png'},
    {'type': 'food', 'title': 'Sandwich', 'image': 'lib/assets/images/sandwich.png'},
    {'type': 'food', 'title': 'Taco', 'image': 'lib/assets/images/taco.png'},
    {'type': 'food', 'title': 'Sushi', 'image': 'lib/assets/images/sushi.png'},
    {'type': 'food', 'title': 'Steak', 'image': 'lib/assets/images/steak.png'},
    {'type': 'food', 'title': 'Salad', 'image': 'lib/assets/images/salad.png'},
    {'type': 'drink', 'title': 'Coke', 'image': 'lib/assets/images/coke.png'},
    {'type': 'drink', 'title': 'Pepsi', 'image': 'lib/assets/images/pepsi.png'},
    {'type': 'drink', 'title': 'Water', 'image': 'lib/assets/images/water.png'},
    {'type': 'drink', 'title': 'Juice', 'image': 'lib/assets/images/juice.png'},
    {'type': 'drink', 'title': 'Coffee', 'image': 'lib/assets/images/coffee.png'},
    {'type': 'drink', 'title': 'Tea', 'image': 'lib/assets/images/tea.png'},
    {'type': 'drink', 'title': 'Milkshake', 'image': 'lib/assets/images/milkShake.png'},
    {'type': 'drink', 'title': 'Smoothie', 'image': 'lib/assets/images/smoothie.png'},
    {'type': 'drink', 'title': 'Lemon', 'image': 'lib/assets/images/lemon.png'},
    {'type': 'drink', 'title': 'Mango', 'image': 'lib/assets/images/mango.png'},
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> filteredItems = _items.where((item) {
      bool matchesSearch = item['title']!.toLowerCase().contains(_searchQuery.toLowerCase());
      bool matchesFilter = _filter == 'all' || item['type'] == _filter;
      return matchesSearch && matchesFilter;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Search...',
            border: InputBorder.none,
          ),
          onChanged: (query) {
            setState(() {
              _searchQuery = query;
            });
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _filter = 'all';
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _filter == 'all' ? Colors.green : Colors.grey,
                  ),
                  child: Text('All'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _filter = 'food';
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _filter == 'food' ? Colors.green : Colors.grey,
                  ),
                  child: Text('Foods'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _filter = 'drink';
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _filter == 'drink' ? Colors.green : Colors.grey,
                  ),
                  child: Text('Drinks'),
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderDetailScreen(
                          imagePath: filteredItems[index]['image']!,
                          name: filteredItems[index]['title']!,
                          price: 5.00, // You can set a price based on the item
                          description: 'Delicious ${filteredItems[index]['title']} with rich flavor.',
                        ),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 4,
                    child: Column(
                      children: [
                        Expanded(
                          child: Image.asset(
                            filteredItems[index]['image']!,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            filteredItems[index]['title']!,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
