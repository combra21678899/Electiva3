import 'package:flutter/material.dart';
import '../services/user_service.dart';

class LoginPage extends StatelessWidget {

  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  void login(BuildContext context) {

    final user = UserService.usuarios.firstWhere(
      (u) =>
          u.email == emailCtrl.text &&
          u.password == passwordCtrl.text,
      orElse: () => throw Exception("No encontrado"),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Bienvenido ${user.nombre}"))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Inicio de sesión")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [

            TextField(
              controller: emailCtrl,
              decoration: InputDecoration(labelText: "Email o usuario"),
            ),

            TextField(
              controller: passwordCtrl,
              obscureText: true,
              decoration: InputDecoration(labelText: "Contraseña"),
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () => login(context),
              child: Text("Ingresar"),
            )
          ],
        ),
      ),
    );
  }
}