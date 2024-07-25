import 'package:flutter/material.dart';
import '../amino/client.dart';
import 'home_page.dart';

class RegisterPage extends StatelessWidget {
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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTextField(_nicknameController, 'Никнейм'),
            _buildTextField(_loginController, 'Почта'),
            _buildTextField(_passwordController, 'Пароль'),
            _buildTextField(_verificationController, 'Верификация'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Client client = Client();
                client.getValidationCode(_loginController.text);
              },
              child: const Text('Получить сообщение на почту', style: TextStyle(fontSize: 18)),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                bool registerSuccess = await _registerUser();
                if (registerSuccess) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                }
              },
              child: const Text('Регистрация', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
        ),
        cursorColor: Colors.black,
        style: const TextStyle(fontSize: 18),
      ),
    );
  }

  Future<bool> _registerUser() async {
    Client client = Client();
    try {
      await client.register(
        _nicknameController.text,
        _loginController.text,
        _passwordController.text,
        _verificationController.text,
      );
      return true;
    } catch (e) {
      // Обработка ошибок регистрации
      print(e);
      return false;
    }
  }
}
