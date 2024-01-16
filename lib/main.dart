import 'package:app1/screens/entryScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  if (kIsWeb) {

    // await dotenv.load(fileName: "file_env");
    await Firebase.initializeApp(
      options: const FirebaseOptions(
      apiKey: 'AIzaSyBD4fcmWGGqs-udC7ohPcJ447Imc-NG_bQ',
      appId: '1:906150101683:web:d16b806ad91e587b5c26c6',
      messagingSenderId: '906150101683',
      projectId: 'cp301-5a6a0',
      storageBucket:  'cp301-5a6a0.appspot.com',
    ));
    
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: EntryScreen(),
    );
  }
}
