import 'package:flutter/material.dart';

import '../main.dart';
import 'home_page.dart';

class RegisterPage extends StatelessWidget{
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _verificationController = TextEditingController();

  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Регистрация'),
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextField(
                      controller: _nicknameController,
                      decoration: const InputDecoration(
                          hintText: 'Никнейм',
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
              Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextField(
                      controller: _loginController,
                      decoration: const InputDecoration(
                          hintText: 'Почта',
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
              Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                          hintText: 'Пароль',
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
              Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextField(
                      controller: _verificationController,
                      decoration: const InputDecoration(
                          hintText: 'Верификация',
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
                    account.getValidationCode(
                        _loginController.text
                    );
                  },
                  child: const Text('Получить сообщение на почту',
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.black
                      )
                  )
              ),
              TextButton(
                  onPressed: () {
                    Future<void> registerStatus = account.register(
                        _nicknameController.text,
                        _loginController.text,
                        _passwordController.text,
                        _verificationController.text,
                    );
                    registerStatus.then( (value) {
                        if (account.enterState) {
                          Navigator.pop(context);
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
                              home: const HomePage()
                          )
                        );
                      }
                    });
                  },
                  child: const Text('Регистрация',
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