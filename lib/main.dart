import 'package:flutter/material.dart';

import 'api.dart' as api;
import 'ui/login_page.dart';


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
      home: const LoginPage()
  ));
}

