import "dart:async";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "../models/user.dart" as model;
import "dart:typed_data";

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late UserCredential Cred;


  Future<model.User> getUserDetails() async {
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser == null) {
        // print("user is null");
        throw "user is null";
      } else {
        DocumentSnapshot snap =
            await _firestore.collection('users').doc(currentUser.uid).get();
        // print("the snap is: ${snap.data()}");
        return model.User.fromSnap(snap);
      }
    } catch (e) {
      // print("shit is null");
      // print(e);
      throw e;
    }
  }

}
