import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pharma_bot/pages/home_page.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  Future<void> _signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      // Redirection vers HomePage après déconnexion
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
        (route) => false, // Supprime toute la pile de navigation
      );
    } catch (e) {
      print("Erreur de déconnexion: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Échec de la déconnexion: ${e.toString()}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tableau de bord Admin'),
        automaticallyImplyLeading: false, // Empêche le bouton retour
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.admin_panel_settings,
                size: 50, color: Colors.blue),
            const SizedBox(height: 20),
            const Text(
              'Espace Administrateur',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Connecté en tant que: ${user?.email ?? 'admin'}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              icon: const Icon(Icons.logout),
              label: const Text("Se déconnecter"),
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                backgroundColor: Colors.red,
              ),
              onPressed: () => _signOut(context),
            ),
          ],
        ),
      ),
    );
  }
}
