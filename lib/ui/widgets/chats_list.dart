import 'package:flutter/material.dart';

import 'list_decoration.dart';

import '../../main.dart';

class ChatsList extends StatefulWidget {
  const ChatsList({super.key});

  @override
  ChatsListState createState() => ChatsListState();
}

class ChatsListState extends State<ChatsList> {
  final List<List<String>> _chats = account.getChats();

  @override
  Widget build(BuildContext context){
    return ListView.builder(
        itemCount: _chats.length,
        itemBuilder: (BuildContext context, int index){
          return Padding(
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
                    account.currentChat = _chats[index];
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Chat()
                        )
                    );
                  },
                  child: Row(
                      children: [
                        const ListDecoration(),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(_chats[index][0],
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 22
                              )
                          ),
                        )
                      ]
                  )
              )
          );
        }
    );
  }
}