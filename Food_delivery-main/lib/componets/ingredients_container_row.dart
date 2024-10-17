import 'package:flutter/material.dart';
import 'ingredients_container.dart'; // Assuming this file exists and manages individual ingredient containers.

class IngredientsContainerRow extends StatefulWidget {
  const IngredientsContainerRow({super.key});

  @override
  _IngredientsContainerRowState createState() =>
      _IngredientsContainerRowState();
}

class _IngredientsContainerRowState extends State<IngredientsContainerRow> {
  // List to keep track of the added ingredients
  final List<Map<String, dynamic>> _ingredients = [
    {
      'imagePath': 'assets/images/egg.png',
      'color': Colors.purpleAccent.shade100,
      'isSelected': false
    },
    {
      'imagePath': 'assets/images/beef.png',
      'color': Colors.blue.shade100,
      'isSelected': false
    },
    {
      'imagePath': 'assets/images/onion.png',
      'color': Colors.amber.shade100,
      'isSelected': false
    },
    {
      'imagePath': 'assets/images/tomatoes.png',
      'color': Colors.pink.shade100,
      'isSelected': false
    }
  ];

  void _toggleSelection(int index) {
    setState(() {
      // Toggle the 'isSelected' value
      _ingredients[index]['isSelected'] = !_ingredients[index]['isSelected'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: _ingredients.map((ingredient) {
        int index = _ingredients.indexOf(ingredient);
        return GestureDetector(
          onTap: () => _toggleSelection(index),
          child: IngredientsContainer(
            imagePath: ingredient['imagePath'],
            color: ingredient['isSelected']
                ? ingredient['color'] // Use the color when selected
                : Colors.grey.shade300, // Grey when not selected
          ),
        );
      }).toList(),
    );
  }
}
