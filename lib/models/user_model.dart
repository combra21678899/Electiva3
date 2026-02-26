class UserModel {
  int? id; // se genera automático
  String nombre;
  String apellidos;
  String email;
  String telefono;
  String password;

  UserModel({
    this.id,
    required this.nombre,
    required this.apellidos,
    required this.email,
    required this.telefono,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'apellidos': apellidos,
      'email': email,
      'telefono': telefono,
      'password': password,
    };
  }
}