import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  String _enteredMessage = '';
  TextEditingController _messageInputCtrl = TextEditingController();

  void _sendMessage() async {
    FocusScope.of(context).unfocus();
    this._messageInputCtrl.clear();

    final user = await FirebaseAuth.instance.currentUser();
    final userData =
        await Firestore.instance.collection('users').document(user.uid).get();
    Firestore.instance.collection('chat').add({
      'text': _enteredMessage,
      'createdAt': Timestamp.now(),
      'userId': user.uid,
      'username': userData['username']
    });
  }

  @override
  void dispose() {
    super.dispose();
    this._messageInputCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 10.0),
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
                child: TextField(
              controller: this._messageInputCtrl,
              decoration: InputDecoration(hintText: 'Hi there!'),
              onChanged: (value) {
                setState(() {
                  this._enteredMessage = value;
                });
              },
            )),
            IconButton(
              icon: Icon(
                Icons.send,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: this._enteredMessage.trim().isEmpty
                  ? null
                  : this._sendMessage,
            )
          ],
        ));
  }
}
