import 'package:flutter/material.dart';
import '../amino/client.dart';
import 'home_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _verificationController = TextEditingController();

  bool _showVerification = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF1A1F38), Color.fromARGB(255, 10, 21, 77)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildLogo(),
                    const SizedBox(height: 40),
                    _buildTextField(_nicknameController, 'Никнейм', Icons.person),
                    const SizedBox(height: 20),
                    _buildTextField(_loginController, 'Почта', Icons.email),
                    const SizedBox(height: 20),
                    _buildTextField(_passwordController, 'Пароль', Icons.lock, isPassword: true),
                    const SizedBox(height: 20),
                    if (_showVerification)
                      _buildTextField(_verificationController, 'Код верификации', Icons.verified_user),
                    const SizedBox(height: 30),
                    if (!_showVerification)
                      _buildButton(
                        'Получить код на почту',
                        () async {
                          if (_validateInputs()) {
                            await _getValidationCode();
                            setState(() {
                              _showVerification = true;
                            });
                          }
                        },
                      )
                    else
                      _buildButton('Регистрация', _registerUser),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF00FFA3), Color(0xFF00E0FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00FFA3).withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 15,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: const Text(
        "Nulla",
        style: TextStyle(
          fontSize: 60,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          letterSpacing: 2,
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText, IconData icon, {bool isPassword = false}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.white70),
          prefixIcon: Icon(icon, color: const Color(0xFF00FFA3)),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        ),
      ),
    );
  }

  Widget _buildButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: const Color(0xFF1A1F38),
        backgroundColor: const Color(0xFF00FFA3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        elevation: 5,
      ),
      child: Text(text, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }

  bool _validateInputs() {
    // Добавьте здесь валидацию входных данных
    return _nicknameController.text.isNotEmpty &&
        _loginController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty;
  }

  Future<void> _getValidationCode() async {
    Client client = Client();
    try {
      await client.getValidationCode(_loginController.text);
      // Добавьте обработку успешного получения кода
    } catch (e) {
      // Обработка ошибок
      print(e);
    }
  }

  Future<void> _registerUser() async {
    if (_validateInputs() && _verificationController.text.isNotEmpty) {
      Client client = Client();
      try {
        await client.register(
          _nicknameController.text,
          _loginController.text,
          _passwordController.text,
          _verificationController.text,
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } catch (e) {
        // Обработка ошибок регистрации
        print(e);
      }
    }
  }
}