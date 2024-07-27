import 'package:flutter/material.dart';

import 'ui/login_page.dart';

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

