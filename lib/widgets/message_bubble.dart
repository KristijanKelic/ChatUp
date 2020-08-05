import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble(this.messageText, this.isMe, this.username, {this.key});

  final String messageText;
  final String username;
  final bool isMe;
  final Key key;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: isMe ? Theme.of(context).primaryColor : Colors.grey[300],
            borderRadius: BorderRadius.only(
                topLeft: isMe ? Radius.circular(12) : Radius.circular(0),
                topRight: isMe ? Radius.circular(0) : Radius.circular(12.0),
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12)),
          ),
          width: MediaQuery.of(context).size.width / 2,
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
          margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
          child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(this.username,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isMe ? Colors.white : Colors.black)),
              Text(messageText,
                  style: TextStyle(color: isMe ? Colors.white : Colors.black)),
            ],
          ),
        ),
      ],
    );
  }
}
