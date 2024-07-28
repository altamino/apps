import 'package:flutter/material.dart';
import 'package:nulla_pc/amino/client.dart';
import 'package:nulla_pc/ui/edit_chat_page.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  ChatState createState() => ChatState();
}

class ChatState extends State<Chat> {
  late Future<List<Widget>> _messagesList;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _messageFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _messagesList = _createMessages();
  }

  Future<List<Widget>> _createMessages() async {
    List<Widget> messages = [];

    Client client = Client();
    Map<String, List<String>> messagesText = await client.getMessages();

    for (int i = 0; i < messagesText.length; i++) {
      messages.add(
          Row(
            children: [
              Text(messagesText.values.toList()[i][0]),
              const VerticalDivider(
                color: Colors.black,
                width: 10,
                thickness: 1,
              ),
              Text(messagesText.values.toList()[i][1])
            ]
          )
      );
    }

    return messages;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // title: Text(account.currentChat[0]),
          title: const Text("test"),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) {
                            return EditChatPage();
                          }
                      )
                  );
                },
                icon: const Icon(Icons.edit)
            )
          ],
        ),
        body: Column(
          children: [
            Expanded(
                child: FutureBuilder<List<Widget>>(
                  future: _messagesList,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                          child: CircularProgressIndicator()
                      );
                    } else if (snapshot.hasError) {
                      return const Center(
                          child: Text('Error loading messages')
                      );
                    } else {
                      List<Widget> texts = snapshot.data ?? [];
                      return ListView.builder(
                          itemCount: texts.length,
                          controller: _scrollController,
                          itemBuilder: (BuildContext context, int index) {
                            return texts[index];
                          }
                      );
                    }
                  },
                )
            ),
            TextField(
              controller: _messageFieldController,
              decoration: const InputDecoration(
                hintText: 'Сообщение'
              )
            ),
            TextButton(
                onPressed: () async {
                  Client client = Client();
                  await client.sendMessage(_messageFieldController.text);
                  setState(() {
                    _messagesList = _createMessages();
                    _messageFieldController.text = '';
                  });
                  _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
                },
                child: const Text('Отправить сообщение',
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.black
                    )
                )
            )
          ]
        )
    );
  }
}