import 'package:flutter/material.dart';
import 'package:pharma_bot/pages/auth/login_page.dart';
import 'package:pharma_bot/pages/auth/register_page.dart';
import 'package:pharma_bot/pages/pharmacy/add_medicine_page.dart';
import 'package:pharma_bot/pages/pharmacy/home_page2.dart';
import 'package:pharma_bot/pages/pharmacy/layout_admin.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 188, 213, 254),
      ),
      body: Container(
        color: const Color.fromARGB(255, 188, 213, 254),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(children: [
          const Text(
            "Welcome",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text("Your Haven for Healing and Renewal✨​",
              style: TextStyle(fontSize: 20)),
          const SizedBox(
            height: 40,
          ),
          const Image(
            image: AssetImage('assets/images/home.jpg'),
            width: 400,
            height: 400,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                // **** Sign Up Button ***
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(80, 132, 190, 255),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: () {
                      print("Sign Up button pressed");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterPage()),
                      );
                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(255, 252, 252, 252),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // **** Login Button ***
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: () {
                      print("Login button pressed");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                      );
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(108, 61, 89, 122),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // **** Not Thanks Button ***
                Center(
                  child: GestureDetector(
                    onTap: () {
                      print("No thanks tapped");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LayoutAdmin()),
                      );
                    },
                    child: const Text(
                      'Not thanks',
                      style: TextStyle(
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
