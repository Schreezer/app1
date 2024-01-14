import 'package:cloud_firestore/cloud_firestore.dart';

class User{
  final String email;
  final String uid;
  final String name;
  final String address;

  const User({
    required this.email,
    required this.uid,
    required this.name,
    required this.address,
  });

  Map<String, dynamic> toJson() => {
    // this function when called on the user class, will return a mapping
    // from string to dynamic or can also reffer to it as json type
        'email': email,
        'uid': uid,
        'name': name,
        'address': address
      };

  static User fromSnap(DocumentSnapshot snap) {
    // retrieving the data from the snapshot
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
      email: snapshot['email'] ?? '',
      uid: snapshot['uid'] ?? '',
      name: snapshot['name'] ?? '',
      address: snapshot['address'] ?? '',
    );
  }
}