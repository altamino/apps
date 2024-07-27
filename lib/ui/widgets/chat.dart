import 'package:flutter/material.dart';
import 'package:nulla_pc/amino/client.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  ChatState createState() => ChatState();
}

class ChatState extends State<Chat> {
  late Future<List<Widget>> _messagesList;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _messagesList = _createMessages();
  }

  Future<List<Widget>> _createMessages() async {
    List<Widget> messages = [];

    Client client = Client();
    List<String> messagesText = await client.getMessages();

    for (int i = 0; i < messagesText.length; i++) {
      messages.add(Text(messagesText[i]));
    }

    return messages;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // title: Text(account.currentChat[0]),
          title: const Text("test")
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
                      return Column(
                        children: texts
                      );
                    }
                  },
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