import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pharma_bot/pages/home_page.dart'; // Assurez-vous d'importer votre HomePage

class principlePage extends StatefulWidget {
  const principlePage({super.key});

  @override
  State<principlePage> createState() => _PrinciplePageState();
}

class _PrinciplePageState extends State<principlePage> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> _signOut() async {
    try {
      await auth.signOut();
      // Redirection vers HomePage après déconnexion réussie
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
        (route) => false, // Supprime toutes les routes précédentes
      );
    } catch (e) {
      print("Erreur lors de la déconnexion: ${e.toString()}");
      // Vous pouvez ajouter un SnackBar pour afficher l'erreur à l'utilisateur
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Échec de la déconnexion: ${e.toString()}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tableau de bord'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Connecté en tant que: ${auth.currentUser?.email ?? 'Utilisateur'}",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _signOut, // Utilise la méthode de déconnexion
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: const Text(
                "Se déconnecter",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
