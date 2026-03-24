import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../data/app_data.dart';
import '../models/user.dart';

const List<String> _countries = [
  'Argentina', 'Bolivia', 'Brasil', 'Canada', 'Chile', 'Colombia',
  'Costa Rica', 'Cuba', 'Ecuador', 'El Salvador', 'España', 'Estados Unidos',
  'Francia', 'Guatemala', 'Honduras', 'Italia', 'Jamaica', 'México',
  'Nicaragua', 'Panamá', 'Paraguay', 'Perú', 'Portugal', 'Puerto Rico',
  'República Dominicana', 'Uruguay', 'Venezuela', 'Alemania', 'Australia',
  'China', 'Corea del Sur', 'Japón', 'Reino Unido', 'Rusia', 'Sudáfrica',
  'India', 'Turquía', 'Argentina', 'Noruega', 'Suecia', 'Suiza',
];

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
  final passwordController = TextEditingController();
  bool _passwordVisible = false;

  // País: lo gestionamos con el controller interno del Autocomplete
  TextEditingController? _paisFieldController;

  @override
  void dispose() {
    nombreController.dispose();
    apellidoController.dispose();
    emailController.dispose();
    celularController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void register() {
    if (_formKey.currentState!.validate()) {
      users.add(
        User(
          nombre: nombreController.text,
          apellido: apellidoController.text,
          email: emailController.text,
          celular: celularController.text,
          pais: _paisFieldController?.text ?? '',
          password: passwordController.text,
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('¡Cuenta creada exitosamente!'),
          backgroundColor: const Color(0xFF34C759),
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.all(16),
        ),
      );
      Navigator.pop(context);
    }
  }

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: const Color(0xFF8E8E93), size: 20),
      ),
      validator: validator ??
          (value) => value!.isEmpty ? 'Campo obligatorio' : null,
    );
  }

  Widget _buildPaisField() {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textValue) {
        if (textValue.text.isEmpty) return const [];
        return _countries.where((c) =>
            c.toLowerCase().contains(textValue.text.toLowerCase()));
      },
      onSelected: (String selection) {
        _paisFieldController?.text = selection;
      },
      fieldViewBuilder:
          (context, textEditingController, focusNode, onFieldSubmitted) {
        _paisFieldController = textEditingController;
        return TextFormField(
          controller: textEditingController,
          focusNode: focusNode,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            labelText: 'País',
            prefixIcon: Icon(Icons.public_rounded,
                color: Color(0xFF8E8E93), size: 20),
          ),
          validator: (value) =>
              (value == null || value.isEmpty) ? 'Campo obligatorio' : null,
          onFieldSubmitted: (_) => onFieldSubmitted(),
        );
      },
      optionsViewBuilder: (context, onSelected, options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 0,
            borderRadius: BorderRadius.circular(14),
            color: Colors.white,
            child: Container(
              constraints: const BoxConstraints(maxHeight: 200),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFE5E5EA)),
              ),
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 6),
                shrinkWrap: true,
                itemCount: options.length,
                separatorBuilder: (_, _) => const Divider(
                    height: 1, color: Color(0xFFF2F2F7)),
                itemBuilder: (context, index) {
                  final option = options.elementAt(index);
                  return ListTile(
                    dense: true,
                    leading: const Icon(Icons.public_rounded,
                        size: 16, color: Color(0xFF8E8E93)),
                    title: Text(option,
                        style: const TextStyle(
                            fontSize: 14, color: Color(0xFF1C1C1E))),
                    onTap: () => onSelected(option),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Cuenta'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Center(
                child: Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color:
                        const Color(0xFF5E5CE6).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: const Icon(Icons.person_rounded,
                      size: 38, color: Color(0xFF5E5CE6)),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Column(
                  children: const [
                    Text(
                      'Crea tu cuenta',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1C1C1E),
                        letterSpacing: -0.5,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Completa tus datos para registrarte',
                      style: TextStyle(
                          fontSize: 14, color: Color(0xFF8E8E93)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              _buildField(
                controller: nombreController,
                label: 'Nombre',
                icon: Icons.badge_outlined,
                keyboardType: TextInputType.name,
              ),
              const SizedBox(height: 14),
              _buildField(
                controller: apellidoController,
                label: 'Apellido',
                icon: Icons.badge_outlined,
                keyboardType: TextInputType.name,
              ),
              const SizedBox(height: 14),
              _buildField(
                controller: emailController,
                label: 'Correo electrónico',
                icon: Icons.mail_outline_rounded,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty) return 'Campo obligatorio';
                  if (!RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$').hasMatch(value)) {
                    return 'Ingrese un correo válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 14),
              _buildField(
                controller: celularController,
                label: 'Celular',
                icon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  if (value!.isEmpty) return 'Campo obligatorio';
                  if (value.length < 7) return 'Número demasiado corto';
                  return null;
                },
              ),
              const SizedBox(height: 14),
              _buildPaisField(),
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
                    onPressed: () => setState(
                        () => _passwordVisible = !_passwordVisible),
                  ),
                ),
                validator: (value) =>
                    value!.length < 6 ? 'Mínimo 6 caracteres' : null,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: register,
                child: const Text('Crear Cuenta'),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

