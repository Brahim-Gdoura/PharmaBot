import 'package:flutter/material.dart';
import 'package:pharma_bot/pages/home_page.dart';

void main() {
  runApp(const PharmaBot());
}

class PharmaBot extends StatelessWidget {
  const PharmaBot({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const HomePage(),
    );
  }
}
