import 'package:flutter/material.dart';
import 'package:pharma_bot/pages/pharmacy/add_medicine_page.dart';
import 'package:pharma_bot/pages/pharmacy/chat_bot.dart';
import 'package:pharma_bot/pages/pharmacy/home_page2.dart';

class LayoutAdmin extends StatefulWidget {
  const LayoutAdmin({super.key});

  @override
  State<LayoutAdmin> createState() => _LayoutAdmin();
}

class _LayoutAdmin extends State<LayoutAdmin> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    List myPages = [HomePage2(), ChatBot(), AddMedicinePage()];

    return Scaffold(
        body: myPages[currentIndex],
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (value) => setState(() {
            currentIndex = value;
          }),
          elevation: 0,
          backgroundColor: Colors.white.withOpacity(0.2),
          selectedIndex: currentIndex,
          indicatorColor: const Color.fromARGB(255, 188, 213, 254),
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.message_outlined),
              selectedIcon: Icon(Icons.message),
              label: 'Chat',
            ),
            NavigationDestination(
              icon: Icon(Icons.add_circle_outline),
              selectedIcon: Icon(Icons.add),
              label: 'Add',
            ),
          ],
        ));
  }
}
