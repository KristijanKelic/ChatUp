import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

// WIDGETS
import 'package:ChatUp/widgets/messages.dart';
import 'package:ChatUp/widgets/new_message.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ChatUp'),
          actions: [
            DropdownButton(
              icon: Icon(Icons.more_vert, color: Colors.white),
              items: [
                DropdownMenuItem(
                  value: 'logout',
                  child: Container(
                    child: Row(
                      children: [
                        Icon(Icons.exit_to_app),
                        SizedBox(
                          width: 8.0,
                        ),
                        Text("Logout")
                      ],
                    ),
                  ),
                ),
              ],
              onChanged: (itemIdentifier) {
                if (itemIdentifier == 'logout') {
                  FirebaseAuth.instance.signOut();
                }
              },
            )
          ],
        ),
        body: Container(
          child: Column(
            children: [Expanded(child: Messages()), NewMessage()],
          ),
        ));
  }
}
