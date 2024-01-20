import "dart:async";
import "package:app1/globalVar.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "../models/user.dart" as model;
import "dart:typed_data";

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;// utility of this is yet to be determined
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late UserCredential Cred;

  Future<model.User?> getUserDetails() async {
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser == null) {
        // print("user is null");
        return null;
      } else {
        DocumentSnapshot snap =
            await _firestore.collection('users').doc(currentUser.uid).get();
        return model.User.fromSnap(snap);
      }
    } catch (e) {
      print("the error caught at getting user details" + e.toString());
      throw e;
    }
  }

  Future<String> Send_OTP ({ // initially Login_otp

    required String phone,
  }) async {
    String res = "Some Error Occured";
    var completer = Completer<String>(); // Declare a Completer

    try {
      if (phone.isNotEmpty) {
        await _auth.verifyPhoneNumber(
          phoneNumber: phone,
          verificationCompleted: (PhoneAuthCredential credential) async {
            Cred = await _auth.signInWithCredential(credential);
            res = "success";
            completer.complete(
                res); // Complete the completer when verification is complete
          },
          verificationFailed: (FirebaseAuthException e) {
            if (e.code == "invalid-phone-number") {
              res = "The provided phone number is not valid";
            } else {
              res = e.toString();
            }
            completer.complete(
                res); // Complete the completer when verification fails
          },
          codeSent: (String verificationId, int? resendToken) {
            res = 'code sent';
          
            VerificationId = verificationId;
            completer.complete(
                res);
            // Don't complete the completer here because verification is not yet complete
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            // Handle auto-retrieval timeout if necessary
          },
        );
      }
    } catch (_err) {
      res = _err.toString();
      completer.complete(res); // Complete the completer when there's an error
    }
    print("the value of res in send otp function is: $res");
    return completer.future; // Return the completer's future
  }
  
  Future<String> SubmitOtp(
    String otp,
  ) async {
    String res = "Some Error Occured";
    if (VerificationId != null) {
      final credential = PhoneAuthProvider.credential(
        verificationId: VerificationId,
        smsCode: otp,
      );
      final value = await _signInWithCredential(credential);
      // print("the value of value in _submitOtp funciton is: $value");
      if (value == "success") {
        return "success";
      } else {
        return value;
      }
    } else {
      return "mobile number not submitted";
    }
  }
  
  Future<String> _signInWithCredential(PhoneAuthCredential credential) async {
    try {
      // print("registering new user");
      Cred = await _auth.signInWithCredential(credential);
      // print("success");
      return ("success");
    } catch (e) {
      return e.toString();
    }
  }
  
  Future<String> registerUser(
    // TODO:
    String mailId,
    String name,
    String address,
  ) {
    String res = "Failed";
    return Future.value(res);
  }
Future<String> Login_otp_submit(
    String otp,
  ) async {
    String res = "Some Error Occured";
    if (VerificationId != null) {
      final credential = PhoneAuthProvider.credential(
        verificationId: VerificationId,
        smsCode: otp,
      );
      final value = await _signInWithCredential(credential);
      // print("the value of value in _submitOtp funciton is: $value");
      if (value == "success") {
        return "success";
      } else {
        return value;
      }
    } else {
      return "mobile number not submitted";
    }
  }
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
