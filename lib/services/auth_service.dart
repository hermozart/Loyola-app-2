import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Iniciar sesión con carnet y código (SIN Firebase Auth)
  Future<Map<String, dynamic>> iniciarSesion({
    required String carnet,
    required String codigo,
  }) async {
    try {
      // Buscar estudiante por número de carnet
      final querySnapshot = await _firestore
          .collection('estudiantes')
          .where('numeroCarnet', isEqualTo: carnet)
          .limit(1)
          .get();

      if (querySnapshot.docs.isEmpty) {
        return {'success': false, 'message': 'Carnet no encontrado'};
      }

      final estudianteDoc = querySnapshot.docs.first;
      final estudianteData = estudianteDoc.data();

      // Verificar código
      final codigoRegistro = estudianteData['codigoRegistro'];
      if (codigoRegistro != codigo) {
        return {'success': false, 'message': 'Código incorrecto'};
      }

      // Guardar sesión localmente
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('carnet_logueado', carnet);
      await prefs.setString(
          'nombre_logueado', estudianteData['nombreCompleto'] ?? '');

      return {
        'success': true,
        'message': 'Inicio de sesión exitoso',
        'usuario': {
          'carnet': carnet,
          'nombre': estudianteData['nombreCompleto'],
          'carrera': estudianteData['carrera'],
          'correo': estudianteData['email'],
        }
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Error de conexión: ${e.toString()}'
      };
    }
  }

  // Cerrar sesión
  Future<void> cerrarSesion() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('carnet_logueado');
    await prefs.remove('nombre_logueado');
  }

  // Obtener carnet del usuario actual
  Future<String?> obtenerCarnetActual() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('carnet_logueado');
  }

  // Verificar si el usuario está autenticado
  Future<bool> estaAutenticado() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('carnet_logueado');
  }

  // Obtener datos del usuario logueado
  Future<Map<String, dynamic>?> obtenerDatosUsuario(String carnet) async {
    try {
      final querySnapshot = await _firestore
          .collection('estudiantes')
          .where('numeroCarnet', isEqualTo: carnet)
          .limit(1)
          .get();

      if (querySnapshot.docs.isEmpty) return null;

      return querySnapshot.docs.first.data();
    } catch (e) {
      print('Error al obtener datos del usuario: $e');
      return null;
    }
  }
}
