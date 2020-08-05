import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// WIDGETS
import 'package:ChatUp/widgets/auth_form.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLoading = false;

  void _submitForm(String email, String username, String password, bool isLogin,
      BuildContext ctx) async {
    final fbAuth = FirebaseAuth.instance;
    AuthResult result;
    setState(() {
      _isLoading = true;
    });
    try {
      if (isLogin) {
        result = await fbAuth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        result = await fbAuth.createUserWithEmailAndPassword(
            email: email, password: password);
        await Firestore.instance
            .collection('users')
            .document(result.user.uid)
            .setData({
          'username': username,
          'email': email,
        });
      }
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      dynamic message = 'An error occured';

      if (e.message != null) {
        message = e.message;
      }

      Scaffold.of(ctx).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).errorColor,
      ));
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(this._submitForm, _isLoading),
    );
  }
}
