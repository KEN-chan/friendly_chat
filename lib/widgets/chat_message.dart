import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {

  ChatMessage({ this.text, this.senderName });

  final String text;
  final String senderName;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: buildChatMessageBody(context),
    );
  }

  Widget buildChatMessageBody(BuildContext context) {

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        buildAvatar(),
        buildTextContainer(context),
      ],
    );
  }

  Widget buildAvatar() {
    return Container(
      margin: EdgeInsets.only(right: 16.0),
      child: CircleAvatar(child: Text(senderName[0])),
    );
  }

  Widget buildTextContainer(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(senderName, style: Theme.of(context).textTheme.subhead),
        Container(
          margin: EdgeInsets.only(top: 5.0),
          child: Text(text),
        ),
      ],
    );
  }
}