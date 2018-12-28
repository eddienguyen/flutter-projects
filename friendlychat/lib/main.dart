import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart'; // to vary theme using DefaultTargetPlatform
import 'package:flutter/cupertino.dart';

const _name = "Lorem ipsum";

final ThemeData kIOSTheme = new ThemeData(
    primarySwatch: Colors.lightBlue,
    primaryColor: Colors.grey[50],
    primaryColorBrightness: Brightness.light,
    accentColor: Colors.blue[300]);

final ThemeData kDefaultTheme = new ThemeData(
  primaryColor: Colors.grey[50],
  accentColor: Colors.blue[300],
);

// each message
class ChatMessage extends StatelessWidget {
  ChatMessage({this.text, this.controller});

  final String text;
  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: new CurvedAnimation(parent: controller, curve: Curves.easeOut),
      // sizeFactor:
      //     new CurvedAnimation(parent: controller, curve: Curves.easeOut),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(right: 16.0),
              child: CircleAvatar(
                child: Text(_name[0]),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    _name,
                    style: Theme.of(context).textTheme.subhead,
                  ),
                  Container(
                    child: Text(text),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ChatScreen extends StatefulWidget {
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _textController = new TextEditingController();
  bool _isComposing = false;

  _handleSubmitted(String text) {
    _textController.clear();
    ChatMessage newMessage = new ChatMessage(
      text: text,
      controller: new AnimationController(
          duration: Duration(milliseconds: 700), vsync: this),
    );
    setState(() {
      // 'add' method add a new value to the end of list
      // _messages.add(new ChatMessage(
      //   text: text,`
      // ));
      // 'insert' method add a new value to list with a specifict index
      _messages.insert(0, newMessage);
      _isComposing = false;
    });
    newMessage.controller.forward();
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).accentColor),
      child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            children: <Widget>[
              Flexible(
                child: TextField(
                  controller: _textController,
                  onSubmitted: _handleSubmitted,
                  onChanged: (String text) {
                    setState(() {
                      _isComposing = text.length > 0;
                    });
                  },
                  decoration:
                      InputDecoration.collapsed(hintText: "Send a message"),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                child: Theme.of(context).platform == TargetPlatform.iOS
                    ? new CupertinoButton(
                        child: Text('Send'),
                        onPressed: _isComposing
                            ? () => _handleSubmitted(_textController.text)
                            : null,
                      )
                    : IconButton(
                        icon: Icon(Icons.send),
                        onPressed: _isComposing
                            ? () => _handleSubmitted(_textController.text)
                            : null,
                      ),
              )
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Friendly chat'),
        elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 5.0,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Flexible(
              child: ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemBuilder: (_, int index) {
                  return _messages[index];
                },
                itemCount: _messages.length,
                reverse: true,
              ),
            ),
            Divider(),
            Container(
              decoration: BoxDecoration(color: Theme.of(context).cardColor),
              child: _buildTextComposer(),
            )
          ],
        ),
        decoration: BoxDecoration(
            border: Theme.of(context).platform == TargetPlatform.iOS
                ? Border(top: BorderSide(color: Colors.grey[300]))
                : null),
      ),
    );
  }

  @override
  void dispose() {
    _messages.forEach((message) => message.controller.dispose());
    super.dispose();
  }
}

class FriendlyChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "FriendlyChat",
      theme: defaultTargetPlatform == TargetPlatform.iOS
          ? kIOSTheme
          : kDefaultTheme,
      home: ChatScreen(),
    );
  }
}

void main() {
  runApp(FriendlyChat());
}
