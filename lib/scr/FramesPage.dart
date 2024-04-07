import 'package:flutter/material.dart';

class FramesPage extends StatelessWidget {
  // Define a list of frame sizes with their dimensions
  final List<Map<String, String?>> frameSizes = [
    {'size': '4x6 inches', 'dimensions': '10x15 cm'},
    {'size': '5x7 inches', 'dimensions': '13x18 cm'},
    {'size': '8x10 inches', 'dimensions': '20x25 cm'},
    {'size': '11x14 inches', 'dimensions': '28x36 cm'},
    {'size': '16x20 inches', 'dimensions': '41x51 cm'},
    {'size': '20x24 inches', 'dimensions': '51x61 cm'},
    {'size': '24x36 inches', 'dimensions': '61x91 cm'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Frame Sizes'),
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
              print('Frame size selected: ${frameSizes[index]['size']}');
            },
            child: Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      frameSizes[index]['size'] ?? '', // Add null check
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Dimensions: ${frameSizes[index]['dimensions'] ?? ''}', // Add null check
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
    home: FramesPage(),
  ));
}
