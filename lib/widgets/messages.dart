import 'package:ChatUp/widgets/message_bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseAuth.instance.currentUser(),
        builder: (ctx, user) {
          if (user.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return StreamBuilder(
            stream: Firestore.instance
                .collection('chat')
                .orderBy('createdAt', descending: true)
                .snapshots(),
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (!snapshot.hasData) {
                return Center(
                  child: Text('No messages, start a chat!'),
                );
              }
              final documents = snapshot.data.documents;
              return ListView.builder(
                reverse: true,
                itemBuilder: (ctx, index) {
                  return MessageBubble(
                      documents[index]['text'],
                      documents[index]['userId'] == user.data.uid,
                      documents[index]['username'],
                      key: ValueKey(documents[index].documentID));
                },
                itemCount: documents.length,
              );
            },
          );
        });
  }
}
