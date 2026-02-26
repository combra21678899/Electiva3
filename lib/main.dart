import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// ─────────────────────────────────────────
// MODELOS
// ─────────────────────────────────────────

class User {
  final String nombre;
  final String apellido;
  final String email;
  final String celular;
  final String pais;
  final String password;

  User({
    required this.nombre,
    required this.apellido,
    required this.email,
    required this.celular,
    required this.pais,
    required this.password,
  });
}

class Event {
  final String title;
  final String type;
  final String date;
  final String description;

  Event({
    required this.title,
    required this.type,
    required this.date,
    required this.description,
  });
}

// ─────────────────────────────────────────
// SIMULACIÓN BASE DE DATOS
// ─────────────────────────────────────────

List<User> users = [];
List<Event> events = [];

// ─────────────────────────────────────────
// APP
// ─────────────────────────────────────────

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EventApp',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        scaffoldBackgroundColor: const Color(0xFFF4F6FA),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.indigo,
            foregroundColor: Colors.white,
            elevation: 3,
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
      ),
      home: const LoginPage(),
    );
  }
}

// ─────────────────────────────────────────
// LOGIN
// ─────────────────────────────────────────

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void login() {
    FocusScope.of(context).unfocus();

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
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Inicio de sesión exitoso')),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const CrearEventosPage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Credenciales incorrectas')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(30),
            margin: const EdgeInsets.symmetric(horizontal: 30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.event, size: 80, color: Colors.indigo),
                  const SizedBox(height: 15),
                  const Text(
                    'Bienvenido',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 25),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(labelText: 'Correo electrónico'),
                    validator: (value) => value!.isEmpty ? 'Ingrese su correo' : null,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(labelText: 'Contraseña'),
                    validator: (value) => value!.isEmpty ? 'Ingrese su contraseña' : null,
                  ),
                  const SizedBox(height: 25),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: login,
                      child: const Text('Ingresar'),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const RegisterPage()),
                      );
                    },
                    child: const Text('Crear cuenta'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────
// REGISTRO
// ─────────────────────────────────────────

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final nombreController = TextEditingController();
  final apellidoController = TextEditingController();
  final emailController = TextEditingController();
  final celularController = TextEditingController();
  final paisController = TextEditingController();
  final passwordController = TextEditingController();

  void register() {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState!.validate()) {
      users.add(
        User(
          nombre: nombreController.text,
          apellido: apellidoController.text,
          email: emailController.text,
          celular: celularController.text,
          pais: paisController.text,
          password: passwordController.text,
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cuenta creada correctamente')),
      );

      Navigator.pop(context);
    }
  }

  Widget buildField(TextEditingController controller, String label) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      validator: (value) => value!.isEmpty ? 'Campo obligatorio' : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Cuenta'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                buildField(nombreController, 'Nombre'),
                const SizedBox(height: 15),
                buildField(apellidoController, 'Apellido'),
                const SizedBox(height: 15),
                buildField(emailController, 'Correo'),
                const SizedBox(height: 15),
                buildField(celularController, 'Celular'),
                const SizedBox(height: 15),
                buildField(paisController, 'País'),
                const SizedBox(height: 15),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Contraseña'),
                  validator: (value) =>
                      value!.length < 6 ? 'Mínimo 6 caracteres' : null,
                ),
                const SizedBox(height: 25),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: register,
                    child: const Text('Crear Cuenta'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────
// LISTA DE EVENTOS
// ─────────────────────────────────────────

class CrearEventosPage extends StatefulWidget {
  const CrearEventosPage({super.key});

  @override
  State<CrearEventosPage> createState() => _CrearEventosPageState();
}

class _CrearEventosPageState extends State<CrearEventosPage> {
  void addEvent(Event event) {
    setState(() {
      events.add(event);
    });
  }

  IconData getIcon(String type) {
    switch (type) {
      case 'Musical':
        return Icons.music_note;
      case 'Deportivo':
        return Icons.sports_soccer;
      case 'Conferencia':
        return Icons.mic;
      case 'Festival':
        return Icons.celebration;
      default:
        return Icons.event;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Eventos'),
        centerTitle: true,
      ),
      body: events.isEmpty
          ? const Center(
              child: Text(
                'No hay eventos creados',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) {
                final event = events[index];
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: CircleAvatar(
                      backgroundColor: Colors.indigo.withOpacity(0.1),
                      child: Icon(
                        getIcon(event.type),
                        color: Colors.indigo,
                      ),
                    ),
                    title: Text(
                      event.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('${event.type} • ${event.date}'),
                    onTap: () => showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        title: Text(event.title),
                        content: Text(event.description),
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: const Text('Nuevo'),
        onPressed: () async {
          final newEvent = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CrearEventoFormPage()),
          );
          if (newEvent != null) addEvent(newEvent);
        },
      ),
    );
  }
}

// ─────────────────────────────────────────
// FORMULARIO CREAR EVENTO
// ─────────────────────────────────────────

class CrearEventoFormPage extends StatefulWidget {
  const CrearEventoFormPage({super.key});

  @override
  State<CrearEventoFormPage> createState() => _CrearEventoFormPageState();
}

class _CrearEventoFormPageState extends State<CrearEventoFormPage> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final dateController = TextEditingController();
  final descriptionController = TextEditingController();
  String selectedType = 'Musical';

  final List<String> eventTypes = [
    'Musical',
    'Deportivo',
    'Conferencia',
    'Festival',
    'Otro',
  ];

  void saveEvent() {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState!.validate()) {
      final newEvent = Event(
        title: titleController.text,
        type: selectedType,
        date: dateController.text,
        description: descriptionController.text,
      );
      Navigator.pop(context, newEvent);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Evento'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Título del evento'),
                validator: (value) => value!.isEmpty ? 'Campo obligatorio' : null,
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: selectedType,
                items: eventTypes
                    .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                    .toList(),
                onChanged: (value) => setState(() => selectedType = value!),
                decoration: const InputDecoration(labelText: 'Tipo de evento'),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: dateController,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Fecha',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                onTap: () async {
                  FocusScope.of(context).unfocus();
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2024),
                    lastDate: DateTime(2030),
                  );
                  if (pickedDate != null) {
                    dateController.text =
                        '${pickedDate.day}/${pickedDate.month}/${pickedDate.year}';
                  }
                },
                validator: (value) => value!.isEmpty ? 'Seleccione una fecha' : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: descriptionController,
                maxLines: 3,
                decoration: const InputDecoration(labelText: 'Descripción'),
                validator: (value) => value!.isEmpty ? 'Campo obligatorio' : null,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: saveEvent,
                child: const Text('Guardar Evento'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}