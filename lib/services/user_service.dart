import '../models/user_model.dart';

class UserService {

  static List<UserModel> usuarios = [];

  static int generarId() {
    if (usuarios.isEmpty) {
      return 1;
    }
    return usuarios.last.id! + 1;
  }

  static void registrarUsuario(UserModel user) {
    user.id = generarId();
    usuarios.add(user);

    print("Usuario creado con ID: ${user.id}");
  }
}