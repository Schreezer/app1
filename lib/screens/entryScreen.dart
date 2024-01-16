import "package:app1/resources/authMethods.dart";
import "package:app1/screens/registrationScreen.dart";
import "package:app1/widgets.dart/textField.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:intl_phone_field/intl_phone_field.dart";
import 'package:restart_app/restart_app.dart';

class EntryScreen extends StatefulWidget {
  const EntryScreen({super.key});

  @override
  State<EntryScreen> createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  final TextEditingController mailIdController = TextEditingController();
  bool _isLoading1 = false;
  bool _isLoading2 = false;

  void dispose() {
    super.dispose();
    _phoneNumberController.dispose();
    _otpController.dispose();
    mailIdController.dispose();
  }

  bool validateEmail(String? value) {
    const pattern = r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)';
    final regex = RegExp(pattern);

    if (value == null || value.isEmpty || !regex.hasMatch(value)) {
      return false;
    }
    return true;
  }

  void sendOtp() async {
    // should work on the logic of sending otp TODO: Test this function
    print(_phoneNumberController.text);
    setState(() {
      _isLoading1 = true;
    });
    String res =
        await AuthMethods().Send_OTP(phone: _phoneNumberController.text);

    // print(res);
    if (res == 'success') {
      showSnackBar(context, res);
    } else {
      showSnackBar(context, res);
    }
    setState(() {
      _isLoading1 = false;
    });
  }

  void navigateToSignup() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) =>
            RegistrationScreen(_phoneNumberController.text),
      ),
    );
  }

  Future<void> Next(Provider) async {
    // ignore: unused_local_variable
    var res = 'otp entered';
    setState(() {
      _isLoading2 = true;
    });
    await AuthMethods()
        .Login_otp_submit(_otpController.text)
        .then((value) => res = value);

    if (res == 'success') {
      if (!context.mounted) return;
      showSnackBar(context, res);

      FirebaseAuth auth = FirebaseAuth.instance;
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      String? uid = auth.currentUser?.uid.toString();
      // G_uid = uid!;
      // PhoneNumber = _phoneNumberController.text;
      final snapshot =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (snapshot == null || !snapshot.exists) {
        if (!context.mounted) return;
        Provider.refreshUser(false);
        // PhoneNumber = _phoneNumberController.text;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) =>
                RegistrationScreen(_phoneNumberController.text),
          ),
        );
      } else {
        if (!context.mounted) return;
        Provider.refreshUser(false);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => EntryScreen(),
            ));
        // html.window.location.reload();
        Restart.restartApp();
      }
    } else {
      if (!context.mounted) return;
      showSnackBar(context, res);
    }
    setState(() {
      _isLoading2 = false;
    });
  }
bool validatePhone(String? value) {
  // This pattern allows for an optional '+' followed by any number of digits.
  const pattern = r'^(\+?\d+)$';
  final regex = RegExp(pattern);

  if (value == null || value.isEmpty || !regex.hasMatch(value)) {
    return false;
  }
  return true;
}

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: Divider.createBorderSide(context),
    );
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Welcome to the app", style: TextStyle(fontSize: 20)),
            Container(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child:

                  // TextField(
                  //   controller: mailIdController,
                  //   decoration: InputDecoration(
                  //       hintText: "Enter your phone number",
                  //       border: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(20),
                  //       )),
                  // ),
                  IntlPhoneField(
                decoration: InputDecoration(
                  hintText: 'Phone Number',
                  filled: true,
                  border: inputBorder,
                  focusedBorder: inputBorder,
                  enabledBorder: inputBorder,
                  contentPadding: const EdgeInsets.all(8),
                ),
                keyboardType: TextInputType.phone,

                // controller: _phoneNumberController,
                initialCountryCode: 'IN',
                onChanged: (phone) {
                  setState(() {
                    _phoneNumberController.text = phone.completeNumber;
                  });
                },
              ),
            ),
            Container(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                if (validatePhone(_phoneNumberController.text) == true) {
                  //TODO: check if the validateEmail function is correct

                  // TODO: send the otp:
                  sendOtp();
                  showSnackBar(context, "OTP sent to ${_phoneNumberController.text}");
                } else {
                  showSnackBar(context, "Please enter a valid email");
                }
              },
              child: Text("Request OTP"),
            ),
            ElevatedButton(
              onPressed: () {
                // routes to the registration screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        RegistrationScreen(mailIdController.text),
                  ),
                );
              },
              child: Text("Temporary Button"),
            ),
          ],
        ),
      ),
    );
  }
}
