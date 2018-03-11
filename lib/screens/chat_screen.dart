import 'package:flutter/material.dart';
import '../widgets/chat_message.dart';
import 'package:flutter/cupertino.dart';

class ChatScreen extends StatefulWidget {

  @override
  State createState() {
    return ChatScreenState();
  }
}

class ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {

  final List<ChatMessage> messages = <ChatMessage>[];
  final TextEditingController textController = new TextEditingController();
  bool isComposing = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Friendly Chat"),
        elevation: Theme.of(context).platform == TargetPlatform.iOS ? 1.0 : 4.0,
      ),
      body: buildBody(context),
    );
  }

  @override 
  void dispose() {
    for (ChatMessage message in messages)
      message.animationController.dispose();
    super.dispose();
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
    return new IconTheme(
      data: new IconThemeData(color: Theme.of(context).accentColor),
      child: new Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: new Row(
          children: <Widget>[
            new Flexible(
              child: new TextField(
                controller: textController,
                onChanged: handleChanged,
                onSubmitted: handleSubmitted,
                decoration: new InputDecoration.collapsed(hintText: "Send a message"),
                maxLines: 2,
              ),
            ),
            new Container(
              margin: new EdgeInsets.symmetric(horizontal: 4.0),
              child: buildIconButton(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildIconButton(BuildContext context) {

    return Theme.of(context).platform == TargetPlatform.iOS ? buildIOSButton() : buildAndroidButton();
  }

  Widget buildIOSButton() {

    return CupertinoButton(
      child: Text('Send'),
      onPressed: onPressed(),
    );
  }

  Widget buildAndroidButton() {

    return IconButton(
      icon: Icon(Icons.send),
      onPressed: onPressed(),
    );
  }

  onPressed() {

     return isComposing
        ? () => handleSubmitted(textController.text)
        : null;
  }

  handleChanged(String text) {

    setState(() {
      isComposing = text.length > 0;
    });
  }

  handleSubmitted(String text) {

    if (!isComposing) return;

    textController.clear();

    var message = ChatMessage(
      text: text,
      senderName: "Kenta",
      animationController: AnimationController(
        duration: Duration(milliseconds: 300),
        vsync: this,
      ),
    );
    setState(() {
      isComposing = false;
      messages.insert(0, message);
    });
    message.animationController.forward();
  }
}