import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {

  ChatMessage({ this.text, this.senderName, this.animationController });

  final String text;
  final String senderName;
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: CurvedAnimation(
        parent: animationController, curve: Curves.easeOut,
      ),
      axisAlignment: 0.0,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        child: buildChatMessageBody(context),
      ),
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

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(senderName, style: Theme.of(context).textTheme.subhead),
          Container(
            margin: EdgeInsets.only(top: 5.0),
            child: Text(text),
          ),
        ],
      ),
    );
  }
}