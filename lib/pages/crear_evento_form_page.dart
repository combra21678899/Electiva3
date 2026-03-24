import 'package:flutter/material.dart';
import '../models/event.dart';

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

  final List<Map<String, dynamic>> eventTypes = [
    {'label': 'Musical', 'icon': Icons.music_note_rounded, 'color': Color(0xFFFF9500)},
    {'label': 'Deportivo', 'icon': Icons.sports_soccer_rounded, 'color': Color(0xFF34C759)},
    {'label': 'Conferencia', 'icon': Icons.mic_rounded, 'color': Color(0xFF007AFF)},
    {'label': 'Festival', 'icon': Icons.celebration_rounded, 'color': Color(0xFF5E5CE6)},
    {'label': 'Otro', 'icon': Icons.event_rounded, 'color': Color(0xFF8E8E93)},
  ];

  @override
  void dispose() {
    titleController.dispose();
    dateController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  void saveEvent() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(
        context,
        Event(
          title: titleController.text,
          type: selectedType,
          date: dateController.text,
          description: descriptionController.text,
        ),
      );
    }
  }

  Future<void> pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(primary: Color(0xFF5E5CE6)),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      setState(() {
        dateController.text =
            '${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo Evento'),
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
              const Text(
                'Detalles del evento',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1C1C1E),
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Completa la información del evento',
                style: TextStyle(fontSize: 14, color: Color(0xFF8E8E93)),
              ),
              const SizedBox(height: 28),
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Título',
                  prefixIcon: Icon(Icons.title_rounded,
                      color: Color(0xFF8E8E93), size: 20),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Campo obligatorio' : null,
              ),
              const SizedBox(height: 20),
              const Text(
                'Tipo de evento',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF8E8E93),
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: eventTypes.map((type) {
                  final isSelected = selectedType == type['label'];
                  final color = type['color'] as Color;
                  return GestureDetector(
                    onTap: () =>
                        setState(() => selectedType = type['label'] as String),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 9),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? color.withValues(alpha: 0.12)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color:
                              isSelected ? color : const Color(0xFFE5E5EA),
                          width: isSelected ? 1.5 : 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(type['icon'] as IconData,
                              size: 16,
                              color: isSelected
                                  ? color
                                  : const Color(0xFF8E8E93)),
                          const SizedBox(width: 6),
                          Text(
                            type['label'] as String,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                              color: isSelected
                                  ? color
                                  : const Color(0xFF1C1C1E),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: dateController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Fecha',
                  prefixIcon: const Icon(Icons.calendar_today_rounded,
                      color: Color(0xFF8E8E93), size: 20),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.arrow_drop_down_rounded,
                        color: Color(0xFF8E8E93)),
                    onPressed: pickDate,
                  ),
                ),
                onTap: pickDate,
                validator: (value) =>
                    value!.isEmpty ? 'Seleccione una fecha' : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: descriptionController,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Descripción',
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(bottom: 60),
                    child: Icon(Icons.description_outlined,
                        color: Color(0xFF8E8E93), size: 20),
                  ),
                  alignLabelWithHint: true,
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Campo obligatorio' : null,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: saveEvent,
                child: const Text('Guardar Evento'),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
