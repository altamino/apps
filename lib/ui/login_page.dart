import 'package:flutter/material.dart';

import 'home_page.dart';

import '../main.dart';

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
                    decoration: const InputDecoration(
                        hintText: 'Имя пользователя',
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
            TextButton(
                onPressed: () async {
                  await account.enter(
                      _loginController.text,
                      _passwordController.text
                  );
                  debugPrint(account.enterState.toString());
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
                            home: const HomePage()
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