import 'package:app1/providers/userprovider.dart';
import 'package:app1/screens/entryScreen.dart';
import 'package:app1/screens/homeScreen.dart';
import 'package:app1/screens/registrationScreen.dart';
import 'package:app1/widgets.dart/textField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // if (kIsWeb) {
  // await dotenv.load(fileName: "file_env");
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'AIzaSyBD4fcmWGGqs-udC7ohPcJ447Imc-NG_bQ',
    appId: '1:906150101683:web:d16b806ad91e587b5c26c6',
    messagingSenderId: '906150101683',
    projectId: 'cp301-5a6a0',
    storageBucket: 'cp301-5a6a0.appspot.com',
  ));

  // } else {
  //   await Firebase.initializeApp();
  // }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => UserProvider(),
          ),
        ],
        child: MaterialApp(
          home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  // by now we have confirmed that the user is authenticated previously
                  return FutureBuilder(
                    future: Provider.of<UserProvider>(context, listen: false)
                        .refreshUser(true),
                    builder: (context, asyncSnapshot) {
                      if (asyncSnapshot.connectionState ==
                          ConnectionState.done) {
                        final userProvider =
                            Provider.of<UserProvider>(context, listen: false);
                        if (userProvider.getUser != null) {
                          return HomeScreen();
                        } else {
                          showSnackBar(context, "Please Register");
                          return RegistrationScreen(
                            uid: FirebaseAuth.instance.currentUser!.uid,
                            phoneN:
                                FirebaseAuth.instance.currentUser!.phoneNumber!,
                          );
                        }
                      } else {
                        // While waiting for the future to complete, show a loading spinner.
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text("${snapshot.error}"));
                }
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              return const EntryScreen();
            },
          ),
        ));
  }
}
