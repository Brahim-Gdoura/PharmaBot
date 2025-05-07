import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pharma_bot/models/user.dart';

class AuthMethods {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final CollectionReference users =
      FirebaseFirestore.instance.collection("users");

  Future<String> signUp({
    required String email,
    required String password,
    required String username,
    required String display,
  }) async {
    try {
      // Validation des champs
      if (email.isEmpty ||
          password.isEmpty ||
          username.isEmpty ||
          display.isEmpty) {
        return "All fields are required";
      }

      if (password.length < 6) {
        return "Password must be at least 6 characters";
      }

      // Création de l'utilisateur
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      // Création du modèle utilisateur
      UserModel user = UserModel(
        uid: userCredential.user!.uid,
        email: email.trim(),
        username: username.trim(),
        displayName: display.trim(),
        role: "user",
      );

      // Sauvegarde dans Firestore
      await users.doc(user.uid).set(user.toJson());

      return "success";
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          return 'The email address is already in use.';
        case 'invalid-email':
          return 'The email address is not valid.';
        case 'operation-not-allowed':
          return 'Email/password accounts are not enabled.';
        case 'weak-password':
          return 'The password is too weak.';
        default:
          return e.message ?? 'An unknown error occurred.';
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> signIn(
      {required String email, required String password}) async {
    try {
      // Validation des champs
      if (email.isEmpty || password.isEmpty) {
        return "All fields are required";
      }

      // Connexion de l'utilisateur
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      return "success";
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          return 'No user found for that email.';
        case 'wrong-password':
          return 'Wrong password provided for that user.';
        default:
          return e.message ?? 'An unknown error occurred.';
      }
    } catch (e) {
      return e.toString();
    }
  }

  // **** Retrieve User Details ****
  Future<UserModel?> getUserDetails() async {
    try {
      User? user = auth.currentUser;
      if (user != null) {
        DocumentSnapshot doc = await users.doc(user.uid).get();
        return UserModel.fromJson(doc.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
