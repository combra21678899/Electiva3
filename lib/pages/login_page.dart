import 'package:flutter/material.dart';
import '../data/app_data.dart';
import '../models/user.dart';
import 'register_page.dart';
import 'eventos_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _passwordVisible = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void login() {
    if (_formKey.currentState!.validate()) {
      final user = users.firstWhere(
        (u) =>
            u.email == emailController.text &&
            u.password == passwordController.text,
        orElse: () => User(
          nombre: '',
          apellido: '',
          email: '',
          celular: '',
          pais: '',
          password: '',
        ),
      );

      if (user.email.isNotEmpty) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const EventosPage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Credenciales incorrectas'),
            backgroundColor: const Color(0xFFFF3B30),
            behavior: SnackBarBehavior.floating,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            margin: const EdgeInsets.all(16),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 64),
                Container(
                  width: 84,
                  height: 84,
                  decoration: BoxDecoration(
                    color: const Color(0xFF5E5CE6).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(26),
                  ),
                  child: const Icon(
                    Icons.person_rounded,
                    size: 46,
                    color: Color(0xFF5E5CE6),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Eventia',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1C1C1E),
                    letterSpacing: -0.8,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Inicia sesión para continuar',
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xFF8E8E93),
                  ),
                ),
                const SizedBox(height: 48),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Correo electrónico',
                    prefixIcon: Icon(Icons.mail_outline_rounded,
                        color: Color(0xFF8E8E93), size: 20),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? 'Ingrese su correo' : null,
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: passwordController,
                  obscureText: !_passwordVisible,
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    prefixIcon: const Icon(Icons.lock_outline_rounded,
                        color: Color(0xFF8E8E93), size: 20),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _passwordVisible
                            ? Icons.visibility_off_rounded
                            : Icons.visibility_rounded,
                        color: const Color(0xFF8E8E93),
                        size: 20,
                      ),
                      onPressed: () =>
                          setState(() => _passwordVisible = !_passwordVisible),
                    ),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? 'Ingrese su contraseña' : null,
                ),
                const SizedBox(height: 28),
                ElevatedButton(
                  onPressed: login,
                  child: const Text('Ingresar'),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '¿No tienes cuenta?',
                      style:
                          TextStyle(color: Color(0xFF8E8E93), fontSize: 14),
                    ),
                    TextButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const RegisterPage()),
                      ),
                      child: const Text('Crear cuenta'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
