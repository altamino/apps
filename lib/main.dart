import 'package:flutter/material.dart';

import 'package:nulla_pc/api.dart' as api;

api.Account account = api.Account();

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

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _errorText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.black,
                      width: 5
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(10))
              ),
              child: const Text('Nulla App',
                  style: TextStyle(
                      fontSize: 40
                  )
              ),
            ),

            Padding(
                padding: const EdgeInsets.all(20),
                child: TextField(
                    controller: _loginController,
                    style: const TextStyle(
                        fontSize: 22
                    )
                )
            ),
            Padding(
                padding: const EdgeInsets.all(20),
                child: TextField(
                    controller: _passwordController,
                    style: const TextStyle(
                        fontSize: 22
                    )
                )
            ),
            TextButton(
                onPressed: () {
                  account.enter(
                      _loginController.text,
                      _passwordController.text
                  );
                  if (account.enterState == 200 &&
                      _loginController.text != '' &&
                      _passwordController.text != '') {
                    runApp(
                        MaterialApp(
                            theme: ThemeData(
                              textButtonTheme: TextButtonThemeData(
                                style: TextButton.styleFrom(
                                    foregroundColor: Colors.blue
                                )
                              ),
                              tabBarTheme: TabBarTheme(
                                indicatorColor: Colors.blue,
                                labelColor: Colors.blue,
                                overlayColor: TextButton.styleFrom(
                                      foregroundColor: Colors.blue
                                    ).overlayColor
                              )
                            ),
                            home: CommunitiesList()
                        )
                    );

                  } else {
                    setState(() {
                      _errorText = 'Не введён логин или пароль';
                    });
                  }
                },
                child: const Text('Войти', style: TextStyle(
                    fontSize: 22,
                    color: Colors.black
                ))
            ),
            Text(_errorText,
                style: const TextStyle(
                    color: Colors.red,
                    fontSize: 20
                )
            )
          ]
      ),
    );
  }
}

class CommunitiesList extends StatelessWidget {
  final List<List<String>> _communities = account.getCommunities();

  CommunitiesList({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
        body: ListView.builder(
            itemCount: _communities.length,
            itemBuilder: (BuildContext context, int index) {
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
                        account.currentCommunity = _communities[index];
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Community()
                            )
                        );
                      },
                      child: Container(
                          decoration: const BoxDecoration(
                              border: Border(
                                  left: BorderSide(
                                      width: 10,
                                      color: Colors.blue
                                  )
                              )
                          ),
                          padding: const EdgeInsets.all(10),
                          child: Text(_communities[index][0],
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 22
                              )
                          )
                      )
                  )
              );
            })
    );
  }
}

class Community extends StatelessWidget {
  const Community({super.key});
  
  @override
  Widget build(BuildContext context){
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(account.currentCommunity[0]),
          bottom: const TabBar(
              tabs: [
                Tab(text: 'Посты'),
                Tab(text: 'Чаты')
              ]
          ),
        ),
        body: TabBarView(
          children: [
            PostsList(),
            ChatsList()
          ]
        )
      ),
    );
  }
}

class PostsList extends StatelessWidget {
  final List<List<String>> _posts = account.getPosts();

  PostsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: _posts.length,
        itemBuilder: (BuildContext context, int index) {
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
                    account.currentPost = _posts[index];
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Post()
                        )
                    );
                  },
                  child: Container(
                      decoration: const BoxDecoration(
                          border: Border(
                              left: BorderSide(
                                  width: 10,
                                  color: Colors.blue
                              )
                          )
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Text(_posts[index][0],
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 22
                          )
                      )
                  )
              )
          );
        }
    );
  }
}

class ChatsList extends StatelessWidget {
  final List<List<String>> _chats = account.getChats();

  ChatsList({super.key});

  @override
  Widget build(BuildContext context){
    return ListView.builder(
            itemCount: _chats.length,
            itemBuilder: (BuildContext context, int index) {
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
                                builder: (context) => Chat()
                            )
                        );
                      },
                      child: Container(
                          decoration: const BoxDecoration(
                              border: Border(
                                  left: BorderSide(
                                      width: 10,
                                      color: Colors.blue
                                  )
                              )
                          ),
                          padding: const EdgeInsets.all(10),
                          child: Text(_chats[index][0],
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 22
                              )
                          )
                      )
                  )
              );
            }
            );
  }
}

class Post extends StatelessWidget {
  final List<String> _postInformation = account.getPostInformation();

  Post({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(_postInformation[0])
      ),
      body: Text(_postInformation[1])
    );
  }
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