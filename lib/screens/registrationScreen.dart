import "package:app1/resources/fireStore.dart";
import "package:app1/widgets.dart/textField.dart";
import "package:flutter/material.dart";
import "package:restart_app/restart_app.dart";
import "../models/user.dart" as model;

class RegistrationScreen extends StatefulWidget {
  String phoneN;
  String uid;
  RegistrationScreen({required this.phoneN, required this.uid, Key? key})
      : super(key: key);
  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  fireStoreMethods _fireStoreMethods = fireStoreMethods();
  model.User _user =
      model.User(phone: '', uid: '', name: '', address: '', mail: '');

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
                  "Since ${widget.phoneN} is not registered, please enter your details:",
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
                    mail: _user.mail,
                    phone: widget.phoneN,
                    uid: widget.uid,
                    name: value ?? '',
                    address: _user.address),
              ),
              Container(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
                onSaved: (value) => _user = model.User(
                    mail: value ?? '',
                    phone: widget.phoneN,
                    uid: widget.uid,
                    name: _user.name,
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
                    mail: _user.mail,
                    phone: widget.phoneN,
                    uid: widget.uid,
                    name: _user.name,
                    address: value ?? ''),
              ),
              Container(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // TODO: Save _user to your database
                    print("saving user to database");
                    print(
                        "the data being added is as follows: ${_user.name}, ${_user.address}, ${_user.phone}, ${_user.uid}");
                    try {
                      bool result = await _fireStoreMethods.addUser(
                          mail: _user.mail,
                          name: _user.name,
                          address: _user.address,
                          phone: _user.phone,
                          uid: _user.uid);
                      if (result == true) {
                        showSnackBar(context, "User added successfully");
                        Restart.restartApp();
                      } else {
                        showSnackBar(context, "Some error occured");
                      }
                    } catch (e) {
                      debugPrint(e.toString());
                      showSnackBar(context, "Some error occured");
                    }
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
