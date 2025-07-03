import 'package:flutter/material.dart';
import 'package:pharma_bot/pages/pharmacy/chat_bot.dart';
import 'package:pharma_bot/pages/pharmacy/principle_page.dart';

class LayoutUser extends StatefulWidget {
  const LayoutUser({super.key});

  @override
  State<LayoutUser> createState() => _LayoutUser();
}

class _LayoutUser extends State<LayoutUser> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    List myPages = [principlePage(), ChatBot()];

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
          ],
        ));
  }
}
