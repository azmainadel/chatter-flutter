import 'package:chatter/bloc/authentication/authentication_bloc.dart';
import 'package:chatter/bloc/authentication/authentication_event.dart';
import 'package:chatter/ui/components/message_bubble.dart';
import 'package:chatter/ui/util/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final _firestore = Firestore.instance;

class ChatScreen extends StatelessWidget {
  final messageTextController = TextEditingController();
  String messageText;

  final String userName;

  ChatScreen({this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                BlocProvider.of<AuthenticationBloc>(context).add(
                  SignedOut(),
                );
              }),
        ],
        title: Text('Chatroom'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessageStream(signedInUserEmail: userName),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      style: TextStyle(
                        color: Colors.black54,
                      ),
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      messageTextController.clear();
                      _firestore.collection('messages').add({
                        'text': messageText,
                        'sender': userName,
                        'timestamp': DateTime.now().millisecondsSinceEpoch
                      });
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageStream extends StatelessWidget {
  String signedInUserEmail;

  MessageStream({this.signedInUserEmail});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('messages')
          .orderBy('timestamp', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final messagesFromFirestore = snapshot.data.documents;
          List<MessageBubble> messageBubbleList = [];

          for (var message in messagesFromFirestore) {
            final messageText = message.data['text'];
            final messageSender = message.data['sender'];
            final messageTime = message.data['timestamp'];
            final currentUser = signedInUserEmail;

            final messageBubble = MessageBubble(
              text: messageText,
              sender: messageSender,
              timestamp: messageTime,
              isFromCurrentUser: currentUser == messageSender,
            );

            messageBubbleList.add(messageBubble);
          }

          return Expanded(
            child: ListView(
              reverse: true,
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              children: messageBubbleList,
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
      },
    );
  }
}
