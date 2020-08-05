import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

// SCREENS
import 'package:ChatUp/screens/auth_screen.dart';
import 'package:ChatUp/screens/chat_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final fbAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChatUp',
      theme: ThemeData(
          primaryColor: Color(0xFF138B73),
          backgroundColor: Color(0xFF138B73),
          accentColor: Colors.greenAccent,
          accentColorBrightness: Brightness.dark,
          buttonTheme: ButtonTheme.of(context).copyWith(
              buttonColor: Colors.green,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)))),
      home: StreamBuilder(
          stream: fbAuth.onAuthStateChanged,
          builder: (ctx, snapshot) {
            if (snapshot.hasData) {
              return ChatScreen();
            } else {
              return AuthScreen();
            }
          }),
    );
  }
}
