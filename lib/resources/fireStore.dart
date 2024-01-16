import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:app1/models/user.dart" as model;
class fireStoreMethods{
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<bool> addUser({required String name, required String address, required String phone}) async {
    // should work on the logic of sending otp TODO: Test this function
    model.User user = model.User(
      name: name,
      address: address,
       email: '',
    );
    return true;
  }
}