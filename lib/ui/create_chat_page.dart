import 'package:flutter/material.dart';
import 'package:nulla_pc/amino/client.dart';
import 'package:nulla_pc/ui/chat_page.dart';

class CreateChatPage extends StatelessWidget{
  final TextEditingController _titleController = TextEditingController();

  CreateChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Создание чата'),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
                padding: const EdgeInsets.all(20),
                child: TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                        hintText: 'Название чата',
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue)
                        )
                    ),
                    cursorColor: Colors.black,
                    style: const TextStyle(
                        fontSize: 22
                    )
                )
            ),
            TextButton(
                onPressed: () {
                  Client client = Client();
                  client.createChat(
                    _titleController.text
                  );
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (BuildContext content) {
                      return const Chat();
                    })
                  );
                },
                child: const Text('Создать чат',
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.black
                    )
                )
            )
          ]
      ),
    );
  }
}