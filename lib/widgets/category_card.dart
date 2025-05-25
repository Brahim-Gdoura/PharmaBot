import 'package:flutter/material.dart';

class CategoryCard extends StatefulWidget {
  final String title;

  const CategoryCard({super.key, required this.title});

  @override
  State<CategoryCard> createState() => _CategoryCard(title);
}

class _CategoryCard extends State<CategoryCard> {
  final String title;

  _CategoryCard(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Center(
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
