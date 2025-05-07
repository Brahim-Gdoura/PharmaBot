import 'package:flutter/material.dart';
import 'package:pharma_bot/models/user.dart';
import 'package:pharma_bot/pages/auth/register_page.dart';
import 'package:pharma_bot/pages/pharmacy/admin_page.dart';
import 'package:pharma_bot/pages/pharmacy/principle_page.dart';
import 'package:pharma_bot/services/auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  signIn() async {
    try {
      String result = await AuthMethods().signIn(
        email: emailController.text,
        password: passwordController.text,
      );

      if (result == "success") {
        UserModel? user = await AuthMethods().getUserDetails();
        if (user != null) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => user.role == "admin"
                  ? const AdminPage()
                  : const principlePage(),
            ),
            (route) => false,
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result)),
        );
      }
    } on Exception catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Welcome Back",
                      style: TextStyle(
                        fontSize: 26,
                        color: Color.fromRGBO(122, 134, 208, 1),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                // **** Logo ****
                const Center(
                    child: Image(
                        image: AssetImage('assets/images/login.png'),
                        width: 300,
                        height: 300,
                        fit: BoxFit.cover)),

                const SizedBox(
                  height: 16,
                ),

                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Sign in Now",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 16,
                ),

                // **** email ****
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromRGBO(232, 234, 250, 1),
                    prefixIcon: const Icon(Icons.email),
                    hintText: 'Email',
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius:
                          BorderRadius.circular(16), // 👈 ici, c'est correct
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromRGBO(122, 134, 208, 1), width: 2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 16,
                ),

                // **** password ****
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromRGBO(232, 234, 250, 1),
                    prefixIcon: const Icon(Icons.password),
                    hintText: 'Password',
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromRGBO(122, 134, 208, 1), width: 2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 16,
                ),

                // **** login button ****
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(122, 134, 208, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: () {
                      signIn();
                    },
                    child: const Text(
                      'LOGIN',
                      style: TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(255, 252, 252, 252),
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                // **** have an account ****
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    GestureDetector(
                        onTap: () => Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RegisterPage(),
                              ),
                              (route) => false,
                            ),
                        child: const Text(
                          "Register Now",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 122, 134, 208),
                            fontWeight: FontWeight.bold,
                          ),
                        ))
                  ],
                )
              ],
            )),
      ),
    ));
  }
}
