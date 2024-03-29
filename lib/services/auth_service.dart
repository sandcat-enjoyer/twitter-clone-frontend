import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:spark/data/user.dart";

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //email and password sign up
  Future<void> signUp(String email, String password, String username, BuildContext context) async {
    try {
      UserCredential authResult = await FirebaseAuth.instance
      .createUserWithEmailAndPassword(email: email, password: password);

      await FirebaseFirestore.instance.collection("users").doc(authResult.user!.uid).set({
        "username": username,
        "email": email,
        "posts": [],
        "profilePictureUrl": "",
        "headerUrl": "",
        "pronouns": "",
        "bio": "",
        "displayname": username.toUpperCase()
      });

      await authResult.user?.sendEmailVerification();

      await FirebaseAuth.instance.signOut();

      showDialog(context: context, builder: (context) {
        return AlertDialog(
          title: const Text("Account created successfully!"),
          content: Text("A verification e-mail has been sent to ${authResult.user?.email}. Please check your inbox and sign in to your account afterwards."),
          actions: [
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      });

      //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home(user: UserLocal(uid: authResult.user!.uid, displayName: username.toUpperCase(), profilePictureUrl: "", username: username, bio: ""))));
     
    }
    catch (e) {
      print("Error during sign up: $e");
      return;
    }
  }

  //email and password sign in
  Future<UserCredential?> signIn(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(email: email, password: password);
    }
    catch (e) {
      print("Error during sign in: $e");
      return null;
    }
  }

  Future<UserLocal> getUserData(String uid) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> userSnapshot = await FirebaseFirestore.instance.collection("users").doc(uid).get();
      print(userSnapshot.data());
      if (userSnapshot.exists) {
        print("We try to do IT Haha");
        return UserLocal.fromMap(userSnapshot.data()!, _auth.currentUser!.uid);
      }
      else {
        throw Exception("User data not found.");
      }
    } catch(e) {
      print("Error getting user data: $e");
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

}