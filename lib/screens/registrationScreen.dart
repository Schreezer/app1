import "package:flutter/material.dart";
import "../models/user.dart" as model;

class RegistrationScreen extends StatefulWidget {
  String mailId;
  RegistrationScreen(this.mailId, {Key? key}) : super(key: key);
  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  model.User _user = model.User(email: '', uid: '', name: '', address: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Registration", style: TextStyle(fontSize: 24)),
              Container(
                height: 20,
              ),
              Text(
                  "Since ${widget.mailId} is not registered, please enter your details:",
                  style: TextStyle(fontSize: 14)),
              Container(
                height: 30,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onSaved: (value) => _user = model.User(
                    email: _user.email,
                    uid: _user.uid,
                    name: value ?? '',
                    address: _user.address),
              ),
              Container(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your address';
                  }
                  return null;
                },
                onSaved: (value) => _user = model.User(
                    email: _user.email,
                    uid: _user.uid,
                    name: _user.name,
                    address: value ?? ''),
              ),
              Container(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // TODO: Save _user to your database
                  }
                },
                child: Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
