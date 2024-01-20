import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState(); // Call to super.initState() is required.
    getData();
  }

  String name = "";
  String address = "";
  String phone = "";

  Future<void> getData() async {
    // Specify the return type as Future<void>.
    var userSnap = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    setState(() {
      name = userSnap.data()!["name"];
      address = userSnap.data()!["address"];
      phone = userSnap.data()!["phone"];
    });
    // You might want to do something with userSnap here.
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Home Screen"),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 4.0,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title: Text("Name"),
                        subtitle: Text(name),
                        leading: Icon(Icons.person),
                      ),
                      Divider(),
                      ListTile(
                        title: Text("Address"),
                        subtitle: Text(address),
                        leading: Icon(Icons.home),
                      ),
                      Divider(),
                      ListTile(
                        title: Text("Phone"),
                        subtitle: Text(phone),
                        leading: Icon(Icons.phone),
                      ),
                      Divider(),
                      ListTile(
                        title: Text("Email"),
                        subtitle: Text(FirebaseAuth
                            .instance.currentUser!.email
                            .toString()),
                        leading: Icon(Icons.email),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                  },
                  child: Text("Sign Out"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
