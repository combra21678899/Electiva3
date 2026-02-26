import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/user_service.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final nombreCtrl = TextEditingController();
  final apellidosCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final telefonoCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  bool aceptarTerminos = false;

  void crearCuenta() {

    if(!aceptarTerminos) return;

    UserModel nuevoUsuario = UserModel(
      nombre: nombreCtrl.text,
      apellidos: apellidosCtrl.text,
      email: emailCtrl.text,
      telefono: telefonoCtrl.text,
      password: passwordCtrl.text,
    );

    UserService.registrarUsuario(nuevoUsuario);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Cuenta creada correctamente"))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Registro")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [

            TextField(
              controller: nombreCtrl,
              decoration: InputDecoration(labelText: "Nombre"),
            ),

            TextField(
              controller: apellidosCtrl,
              decoration: InputDecoration(labelText: "Apellidos"),
            ),

            TextField(
              controller: emailCtrl,
              decoration: InputDecoration(labelText: "Email"),
            ),

            TextField(
              controller: telefonoCtrl,
              decoration: InputDecoration(labelText: "Teléfono"),
            ),

            TextField(
              controller: passwordCtrl,
              obscureText: true,
              decoration: InputDecoration(labelText: "Contraseña"),
            ),

            CheckboxListTile(
              value: aceptarTerminos,
              title: Text("Aceptar términos y condiciones"),
              onChanged: (value){
                setState(() {
                  aceptarTerminos = value!;
                });
              },
            ),

            ElevatedButton(
              onPressed: crearCuenta,
              child: Text("Crear cuenta"),
            )
          ],
        ),
      ),
    );
  }
}