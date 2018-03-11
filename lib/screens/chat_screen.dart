import 'package:flutter/material.dart';
import '../widgets/chat_message.dart';

class ChatScreen extends StatefulWidget {

  @override
  State createState() {
    return ChatScreenState();
  }
}

class ChatScreenState extends State<ChatScreen> {

  final List<ChatMessage> messages = <ChatMessage>[];
  final TextEditingController textController = new TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Friendly Chat")),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {

    return Column(
      children: <Widget>[
        buildMessageList(),
        Divider(height: 1.0),
        buildTextField(context)
      ],
    );
  }

  Widget buildMessageList() {

    return Flexible(
      child: ListView.builder(
        padding: EdgeInsets.all(8.0),
        reverse: true,
        itemBuilder: (_, int index) => messages[index],
        itemCount: messages.length,
      ),
    );
  }

  Widget buildTextField(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
      ),
      child: buildTextComposer(context),
    );
  }

  Widget buildTextComposer(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: <Widget>[
          Flexible(
            child: TextField(
              controller: textController,
              onSubmitted: handleSubmitted,
              decoration: InputDecoration.collapsed(hintText: "Send a message"),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 4.0),
            child: IconButton(
              icon: Icon(Icons.send),
              color: Theme.of(context).accentColor,
              onPressed: () => handleSubmitted(textController.text) ,
            ),
          )
        ],
      ),
    );
  }

  handleSubmitted(String text) {
    textController.clear();

    var message = ChatMessage(text: text, senderName: "Kenta");
    setState(() {
      messages.insert(0, message);
    });

  }
}