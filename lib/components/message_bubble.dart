import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String text;
  final String sender;

  MessageBubble({this.text, this.sender});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Material(
            borderRadius: BorderRadius.circular(30.0),
            elevation: 6.0,
            color: Colors.lightBlueAccent,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Text(
                '$text',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 4.0,
          ),
          Text(
            'From $sender',
            style: TextStyle(fontSize: 12.0, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
