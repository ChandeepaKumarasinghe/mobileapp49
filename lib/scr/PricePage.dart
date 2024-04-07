import 'package:flutter/material.dart';

class PricesPage extends StatelessWidget {
  // Define a list of frame sizes with their dimensions
  final List<Map<String, String?>> frameSizes = [
    {'service': 'passport / NIC photos', 'price': 'Rs.500'},
    {'service': 'Weddings', 'price': 'Upto Rs.120000'},
    {'service': 'birthdays/Anniversary Celebrations', 'price': 'Upto Rs.40000'},
    {'service': 'Get-together','price':'Upto Rs.40000'},
    {'service': 'Ceremonies','price':'Upto Rs.100000'},
    {'service': 'Graduation ceremonies','price':'Upto Rs.200000'},
    {'service': 'Award Ceremonies','price':'Upto Rs.3000000'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prices'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of columns
          crossAxisSpacing: 10.0, // Spacing between columns
          mainAxisSpacing: 10.0, // Spacing between rows
        ),
        itemCount: frameSizes.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              // Handle onTap event
              print('Service type: ${frameSizes[index]['service']}');
            },
            child: Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      frameSizes[index]['service'] ?? '', // Add null check
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Price: ${frameSizes[index]['price'] ?? ''}', // Add null check
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: PricesPage(),
  ));
}