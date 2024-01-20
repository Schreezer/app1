import 'package:cloud_firestore/cloud_firestore.dart';

class User{
  final String phone;
  final String uid;
  final String name;
  final String address;
  final String mail;

  const User({
    required this.phone,
    required this.uid,
    required this.name,
    required this.address,
    required this.mail,
  });

  Map<String, dynamic> toJson() => {
    // this function when called on the user class, will return a mapping
    // from string to dynamic or can also reffer to it as json type
        'phone': phone,
        'uid': uid,
        'name': name,
        'address': address,
        'mail': mail
      };

  static User fromSnap(DocumentSnapshot snap) {
    // retrieving the data from the snapshot
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
      mail: snapshot['mail'] ?? '',
      phone: snapshot['phone'] ?? '',
      uid: snapshot['uid'] ?? '',
      name: snapshot['name'] ?? '',
      address: snapshot['address'] ?? '',
    );
  }
}