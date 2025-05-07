import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pharma_bot/models/user.dart';

class AuthMethods {
  FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection("users");

  signUp(
      {required String email,
      required String password,
      required String username,
      required String display}) async {
    try {
      if (email.isNotEmpty &&
          password.isNotEmpty &&
          username.isNotEmpty &&
          display.isNotEmpty) {
        UserCredential userCredential =
            await auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        UserModel userModel = UserModel(
          uid: userCredential.user!.uid,
          displayName: display,
          username: username,
          email: email,
          //profilePicture: "",
        );
        FirebaseFirestore.instance
            .collection("users")
            .doc(userCredential.user!.uid)
            .set(
              userModel.toJson(),
            );
        return "success";
      } else {
        return "Please fill all the fields";
      }
    } on Exception catch (e) {
      return e.toString();
    }
  }
}
