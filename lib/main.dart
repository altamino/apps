import 'package:flutter/material.dart';

import 'api.dart' as api;

import 'ui/login_page.dart';

api.Account account = api.Account();

Exchanger exchanger = Exchanger();

void main() {
  runApp(MaterialApp(
      theme: ThemeData(
          textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                  foregroundColor: Colors.blue
              )
          )
      ),
      home: const Login()
  ));
}

class Exchanger {
  Function onPressed = () => null;
  List<List<String>> information = [];
}

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  ChatState createState() => ChatState();
}

class ChatState extends State<Chat> {
  final ScrollController _scrollController = ScrollController();

  List<List<String>> messages = account.getMessages();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(account.currentChat[0]),
        ),
        body: Column(
          children: [
            Expanded(
                child:ListView.builder(
                    controller: _scrollController,
                    itemCount: messages.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Text(messages[index][0],
                        style: const TextStyle(
                            fontSize: 22
                        ),
                      );
                    }
                )
            ),
            TextButton(
                onPressed: () {
                  setState(() {
                    messages.add(['Сообщение', '1']);
                  });
                  _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
                },
                child: const Text('Добавить сообщение',
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.black
                    )
                )
            )
          ],
        )
    );
  }
}