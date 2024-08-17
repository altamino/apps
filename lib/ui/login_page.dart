import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nulla_pc/amino/client.dart';

import 'home_page.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin{
  // TODO: create loading animation
  late AnimationController _controller;
  late Animation<double> _animation;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _hidePassword = true;
  String _errorText = '';

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildAppLogo(),
                    const SizedBox(height: 40),
                    _buildEmailField(),
                    const SizedBox(height: 20),
                    _buildPasswordField(),
                    const SizedBox(height: 10),
                    _buildShowPasswordButton(),
                    _buildForgotPassword(),
                    const SizedBox(height: 30),
                    _buildLoginButton(),
                    const SizedBox(height: 20),
                    _buildDivider(),
                    const SizedBox(height: 20),
                    _buildSocialLoginButtons(),
                    const SizedBox(height: 20),
                    _buildRegisterButton(),
                    const SizedBox(height: 20),
                    _buildErrorText(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppLogo() {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, 4 * _animation.value),
          child: child,
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
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
        child: ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Colors.white, Color(0xFF1A1F38)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ).createShader(bounds),
          child: const Text(
            "Nulla",
            style: TextStyle(
              fontSize: 60,
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat',
              letterSpacing: 2,
              color: Colors.white,
            ),
          ),
        ),
      )
    );
  }

  Widget _buildEmailField() {
    return _buildInputField(
      controller: _emailController,
      hintText: 'Email',
      prefixIcon: Icons.email_outlined,
    );
  }

  Widget _buildPasswordField() {
    return _buildInputField(
      controller: _passwordController,
      hintText: 'Password',
      prefixIcon: Icons.lock_outline,
      obscureText: _hidePassword,
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    required IconData prefixIcon,
    bool obscureText = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.white70),
          prefixIcon: Icon(prefixIcon, color: const Color(0xFF00FFA3)),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        ),
      ),
    );
  }

  Widget _buildForgotPassword() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          // TODO: Implement forgot password functionality
        },
        child: const Text(
          'Forgot Password?',
          style: TextStyle(color: Color(0xFF00FFA3)),
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return ElevatedButton(
      onPressed: _handleLogin,
      style: ElevatedButton.styleFrom(
        foregroundColor: const Color(0xFF1A1F38),
        backgroundColor: const Color(0xFF00FFA3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        elevation: 5,
      ),
      child: const Text('Login', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildDivider() {
    return const Row(
      children: [
        Expanded(child: Divider(color: Colors.white38)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text('Or', style: TextStyle(color: Colors.white70)),
        ),
        Expanded(child: Divider(color: Colors.white38)),
      ],
    );
  }

  Widget _buildSocialLoginButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSocialButton('google_icon.svg'),
        const SizedBox(width: 20),
        _buildSocialButton('facebook_icon.svg'),
        const SizedBox(width: 20),
        _buildSocialButton('twitter_icon.svg'),
      ],
    );
  }

  Widget _buildSocialButton(String assetName) {
    return InkWell(
      onTap: () {
        // TODO: Implement social login
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(
          assetName,
          height: 24,
          width: 24,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildRegisterButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account?", style: TextStyle(color: Colors.white70)),
        TextButton(
          onPressed: _navigateToRegister,
          child: const Text(
            'Register',
            style: TextStyle(color: Color(0xFF00FFA3), fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorText() {
    return Text(
      _errorText,
      style: const TextStyle(color: Color(0xFFFF3B5C), fontSize: 16),
    );
  }

  Widget _buildShowPasswordButton() {
    return TextButton(
        onPressed: () {
          setState(() {
            _hidePassword = !_hidePassword;
          });
        },
        child: const Text('Show password')
    );
  }

  void _handleLogin() async {
    Client client = Client();
    String status = await client.login(_emailController.text, _passwordController.text);
    if (status == 'OK') {
      _navigateToHome();
    } else {
      debugPrint(status);
      _showError(status);
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
      MaterialPageRoute(builder: (context) => const RegisterPage()),
    );
  }

  void _showError(String message) {
    setState(() {
      _errorText = message;
    });
  }
}
