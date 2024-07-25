import 'package:flutter/material.dart';
import 'package:nulla_pc/amino/client.dart';

import 'home_page.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _errorText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildAppLogo(),
            const SizedBox(height: 40),
            _buildEmailField(),
            const SizedBox(height: 20),
            _buildPasswordField(),
            const SizedBox(height: 30),
            _buildLoginButton(),
            const SizedBox(height: 10),
            _buildRegisterButton(),
            const SizedBox(height: 20),
            _buildErrorText(),
          ],
        ),
      ),
    );
  }

  Widget _buildAppLogo() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Padding(
        padding: EdgeInsets.all(10),
        child: Text(
          'Nulla App',
          style: TextStyle(fontSize: 40),
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return TextField(
      controller: _emailController,
      decoration: const InputDecoration(
        hintText: 'Почта',
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
      ),
      cursorColor: Colors.black,
      style: const TextStyle(fontSize: 22),
    );
  }

  Widget _buildPasswordField() {
    return TextField(
      controller: _passwordController,
      obscureText: true,
      decoration: const InputDecoration(
        hintText: 'Пароль',
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
      ),
      cursorColor: Colors.black,
      style: const TextStyle(fontSize: 22),
    );
  }

  Widget _buildLoginButton() {
    return ElevatedButton(
      onPressed: _handleLogin,
      child: const Text('Войти', style: TextStyle(fontSize: 22)),
    );
  }

  Widget _buildRegisterButton() {
    return TextButton(
      onPressed: () => _navigateToRegister(),
      child: const Text('Регистрация', style: TextStyle(fontSize: 22)),
    );
  }

  Widget _buildErrorText() {
    return Text(
      _errorText,
      style: const TextStyle(color: Colors.red, fontSize: 20),
    );
  }

  void _handleLogin() async {
    try {
      Client client = Client();
      await client.login(_emailController.text, _passwordController.text);
      _navigateToHome();
    } catch (e) {
      _showError('Произошла ошибка при входе');
    }
  }

  void _navigateToHome() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  }

  void _navigateToRegister() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterPage()),
    );
  }

  void _showError(String message) {
    setState(() {
      _errorText = message;
    });
  }
}