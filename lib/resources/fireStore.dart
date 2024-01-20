import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:app1/models/user.dart" as model;

class fireStoreMethods {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<bool> addUser(
      {required String mail,
      required String name,
      required String address,
      required String phone,
      required String uid}) async {
    // should work on the logic of sending otp TODO: Test this function
    model.User user = model.User(
        mail: mail, name: name, address: address, uid: uid, phone: phone);
    try {
      await _fireStore.collection("users").doc(uid).set(user.toJson());
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
    return true;
  }
}
