import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  ChatState createState() => ChatState();
}

class ChatState extends State<Chat> {
  final ScrollController _scrollController = ScrollController();
  

  // List<List<String>> messages = account.getMessages();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // title: Text(account.currentChat[0]),
          title: Text("test")
        ),
        body: Column(
          children: [
            Expanded(
                child:ListView.builder(
                    controller: _scrollController,
                    itemCount: 0,
                    itemBuilder: (BuildContext context, int index) {
                      return Text("test",
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
                    // messages.add(['Сообщение', '1']);
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