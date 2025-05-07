import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pharma_bot/models/user.dart';
import 'package:pharma_bot/pages/auth/login_page.dart';
import 'package:pharma_bot/pages/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pharma_bot/pages/pharmacy/admin_page.dart';
import 'package:pharma_bot/pages/pharmacy/principle_page.dart';
import 'package:pharma_bot/services/auth.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const PharmaBot());
}

class PharmaBot extends StatelessWidget {
  const PharmaBot({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          } else if (snapshot.hasData) {
            return FutureBuilder<UserModel?>(
              future: AuthMethods().getUserDetails(),
              builder: (context, userSnapshot) {
                if (userSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (userSnapshot.hasData) {
                  // Redirection en fonction du rôle
                  return userSnapshot.data!.role == "admin"
                      ? const AdminPage()
                      : const principlePage();
                }
                return const LoginPage();
              },
            );
          } else {
            return const HomePage();
          }
        },
      ),
    );
  }
}
