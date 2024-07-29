import 'package:flutter/material.dart';
import 'package:nulla_pc/ui/chat_page.dart';
import 'package:nulla_pc/amino/client.dart';

import 'list_decoration.dart';

class ChatsList extends StatefulWidget {
  const ChatsList({super.key});

  @override
  ChatsListState createState() => ChatsListState();
}

class ChatsListState extends State<ChatsList> {
  late Future<List<Widget>> _chatsList;

  @override
  void initState() {
    super.initState();
    _chatsList = _createButtons();
  }

  Future<List<Widget>> _createButtons() async {
    List<Widget> chatsList = [];
    Client client = Client();
    Map<String, String> chats = await client.getChats();

    for (int i = 0; i < chats.length; i++) {
      chatsList.add(
        Row(
          children: [
            const ListDecoration(),
            Padding(
              padding: const EdgeInsets.all(5),
              child: TextButton(
                style: ButtonStyle(
                    alignment: Alignment.centerLeft,
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)
                        )
                    )
                ),
                onPressed: () {
                  client.chatId = chats.values.toList()[i];
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Chat()
                      )
                  );
                },
                child: Text(chats.keys.toList()[i]),
              ),
            )
          ]
        )
      );
    }
    return chatsList;
  }

  @override
  Widget build(BuildContext context){
    return FutureBuilder<List<Widget>>(
        future: _chatsList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator()
            );
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading chats'));
          } else {
            List<Widget> buttons = snapshot.data ?? [];
            return Column(
              children: buttons,
            );
          }
        }
    );
  }
}