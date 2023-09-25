import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class PropertyPage extends StatelessWidget {
  const PropertyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> items = List.generate(
        20,
        (index) => {
              "id": index,
              "title": "Item $index",
              "height": Random().nextInt(150) + 50.5,
            });

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 180,
              decoration: BoxDecoration(
                color: Colors.pink,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 20),
            RichText(
              text: TextSpan(
                text: ' 11,983 ads in ',
                style: TextStyle(
                    fontSize: 16, color: Colors.black.withOpacity(0.8)),
                children: const [
                  TextSpan(
                    text: 'Khulna',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Scrollbar(
              radius: const Radius.circular(20),
              child: MasonryGridView.count(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: items.length,
                // padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                // the number of columns
                crossAxisCount: 2,
                // vertical gap between two items
                mainAxisSpacing: 4,
                // horizontal gap between two items
                crossAxisSpacing: 4,
                itemBuilder: (context, index) {
                  // display each item with a card
                  return Card(
                    color: Color.fromARGB(
                      Random().nextInt(256),
                      Random().nextInt(256),
                      Random().nextInt(256),
                      Random().nextInt(256),
                    ),
                    // key: ValueKey(_items[index]['id']),
                    child: SizedBox(
                      height: index % 2 == 0 ? 210 : 220,
                      child: Center(
                        child: Text(items[index]['title']),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
