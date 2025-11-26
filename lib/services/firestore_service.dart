import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ==================== NOTICIAS ====================

  // Obtener todas las noticias ordenadas por fecha
  Stream<List<Map<String, dynamic>>> obtenerNoticias() {
    return _firestore
        .collection('noticias')
        .orderBy('fecha', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        var data = doc.data();
        data['id'] = doc.id;
        return data;
      }).toList();
    });
  }

  // Obtener noticias por categoría
  Stream<List<Map<String, dynamic>>> obtenerNoticiasPorCategoria(
      String categoria) {
    if (categoria == 'Todas') {
      return obtenerNoticias();
    }
    return _firestore
        .collection('noticias')
        .where('categoria', isEqualTo: categoria)
        .orderBy('fecha', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        var data = doc.data();
        data['id'] = doc.id;
        return data;
      }).toList();
    });
  }

  // Obtener una noticia por ID
  Future<Map<String, dynamic>?> obtenerNoticia(String noticiaId) async {
    try {
      final doc = await _firestore.collection('noticias').doc(noticiaId).get();
      if (doc.exists) {
        var data = doc.data()!;
        data['id'] = doc.id;
        return data;
      }
      return null;
    } catch (e) {
      print('Error al obtener noticia: $e');
      return null;
    }
  }

  // Buscar noticias
  Stream<List<Map<String, dynamic>>> buscarNoticias(String query) {
    return _firestore
        .collection('noticias')
        .orderBy('fecha', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.where((doc) {
        final titulo = doc.data()['titulo']?.toString().toLowerCase() ?? '';
        final contenido =
            doc.data()['contenido']?.toString().toLowerCase() ?? '';
        final busqueda = query.toLowerCase();
        return titulo.contains(busqueda) || contenido.contains(busqueda);
      }).map((doc) {
        var data = doc.data();
        data['id'] = doc.id;
        return data;
      }).toList();
    });
  }

  // ==================== CALIFICACIONES ====================

  // Obtener notas de un estudiante
  Stream<List<Map<String, dynamic>>> obtenerNotas(String carnet) {
    return _firestore
        .collection('notas')
        .doc(carnet)
        .collection('materias')
        .orderBy('periodo', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        var data = doc.data();
        data['id'] = doc.id;
        return data;
      }).toList();
    });
  }

  // Obtener notas por período
  Stream<List<Map<String, dynamic>>> obtenerNotasPorPeriodo(
      String carnet, String periodo) {
    if (periodo == 'Todas') {
      return obtenerNotas(carnet);
    }
    return _firestore
        .collection('notas')
        .doc(carnet)
        .collection('materias')
        .where('periodo', isEqualTo: periodo)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        var data = doc.data();
        data['id'] = doc.id;
        return data;
      }).toList();
    });
  }

  // Calcular promedio general
  Future<double> calcularPromedio(String carnet) async {
    try {
      final snapshot = await _firestore
          .collection('notas')
          .doc(carnet)
          .collection('materias')
          .get();

      if (snapshot.docs.isEmpty) return 0.0;

      double suma = 0;
      int contador = 0;

      for (var doc in snapshot.docs) {
        final data = doc.data();
        final notaFinal = data['nota_final'];
        if (notaFinal != null) {
          suma += (notaFinal is int) ? notaFinal.toDouble() : notaFinal;
          contador++;
        }
      }

      return contador > 0 ? suma / contador : 0.0;
    } catch (e) {
      print('Error al calcular promedio: $e');
      return 0.0;
    }
  }

  // Contar materias aprobadas
  Future<int> contarMateriasAprobadas(String carnet) async {
    try {
      final snapshot = await _firestore
          .collection('notas')
          .doc(carnet)
          .collection('materias')
          .where('estado', isEqualTo: 'aprobado')
          .get();

      return snapshot.docs.length;
    } catch (e) {
      print('Error al contar materias aprobadas: $e');
      return 0;
    }
  }

  // Contar materias reprobadas
  Future<int> contarMateriasReprobadas(String carnet) async {
    try {
      final snapshot = await _firestore
          .collection('notas')
          .doc(carnet)
          .collection('materias')
          .where('estado', isEqualTo: 'reprobado')
          .get();

      return snapshot.docs.length;
    } catch (e) {
      print('Error al contar materias reprobadas: $e');
      return 0;
    }
  }

  // ==================== AGENDA ====================

  // Obtener eventos de la agenda
  Stream<List<Map<String, dynamic>>> obtenerEventosAgenda(String carnet) {
    return _firestore
        .collection('agenda')
        .doc(carnet)
        .collection('eventos')
        .orderBy('fecha', descending: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        var data = doc.data();
        data['id'] = doc.id;
        return data;
      }).toList();
    });
  }

  // Obtener eventos por tipo
  Stream<List<Map<String, dynamic>>> obtenerEventosPorTipo(
      String carnet, String tipo) {
    if (tipo == 'All') {
      return obtenerEventosAgenda(carnet);
    }

    String tipoFiltro = tipo.toLowerCase();
    if (tipoFiltro == 'classes') tipoFiltro = 'clase';
    if (tipoFiltro == 'exams') tipoFiltro = 'examen';
    if (tipoFiltro == 'meetings') tipoFiltro = 'reunion';

    return _firestore
        .collection('agenda')
        .doc(carnet)
        .collection('eventos')
        .where('tipo', isEqualTo: tipoFiltro)
        .orderBy('fecha', descending: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        var data = doc.data();
        data['id'] = doc.id;
        return data;
      }).toList();
    });
  }

  // Agregar evento a la agenda
  Future<Map<String, dynamic>> agregarEventoAgenda({
    required String carnet,
    required String titulo,
    required String descripcion,
    required DateTime fecha,
    required String horaInicio,
    required String horaFin,
    required String ubicacion,
    required String tipo,
  }) async {
    try {
      await _firestore
          .collection('agenda')
          .doc(carnet)
          .collection('eventos')
          .add({
        'titulo': titulo,
        'descripcion': descripcion,
        'fecha': Timestamp.fromDate(fecha),
        'hora_inicio': horaInicio,
        'hora_fin': horaFin,
        'ubicacion': ubicacion,
        'tipo': tipo,
        'completado': false,
        'creado': FieldValue.serverTimestamp(),
      });

      return {'success': true, 'message': 'Evento agregado exitosamente'};
    } catch (e) {
      return {
        'success': false,
        'message': 'Error al agregar evento: ${e.toString()}'
      };
    }
  }

  // Actualizar evento
  Future<Map<String, dynamic>> actualizarEventoAgenda({
    required String carnet,
    required String eventoId,
    String? titulo,
    String? descripcion,
    DateTime? fecha,
    String? horaInicio,
    String? horaFin,
    String? ubicacion,
    String? tipo,
  }) async {
    try {
      Map<String, dynamic> updates = {};

      if (titulo != null) updates['titulo'] = titulo;
      if (descripcion != null) updates['descripcion'] = descripcion;
      if (fecha != null) updates['fecha'] = Timestamp.fromDate(fecha);
      if (horaInicio != null) updates['hora_inicio'] = horaInicio;
      if (horaFin != null) updates['hora_fin'] = horaFin;
      if (ubicacion != null) updates['ubicacion'] = ubicacion;
      if (tipo != null) updates['tipo'] = tipo;

      if (updates.isNotEmpty) {
        await _firestore
            .collection('agenda')
            .doc(carnet)
            .collection('eventos')
            .doc(eventoId)
            .update(updates);
      }

      return {'success': true, 'message': 'Evento actualizado exitosamente'};
    } catch (e) {
      return {
        'success': false,
        'message': 'Error al actualizar evento: ${e.toString()}'
      };
    }
  }

  // Eliminar evento
  Future<Map<String, dynamic>> eliminarEventoAgenda({
    required String carnet,
    required String eventoId,
  }) async {
    try {
      await _firestore
          .collection('agenda')
          .doc(carnet)
          .collection('eventos')
          .doc(eventoId)
          .delete();

      return {'success': true, 'message': 'Evento eliminado exitosamente'};
    } catch (e) {
      return {
        'success': false,
        'message': 'Error al eliminar evento: ${e.toString()}'
      };
    }
  }

  // ==================== CALENDARIO ACADÉMICO ====================

  // Obtener eventos del calendario académico
  Stream<List<Map<String, dynamic>>> obtenerCalendarioAcademico() {
    return _firestore
        .collection('calendario_academico')
        .where('visible', isEqualTo: true)
        .orderBy('fecha_inicio', descending: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        var data = doc.data();
        data['id'] = doc.id;
        return data;
      }).toList();
    });
  }

  // Obtener eventos del calendario por mes
  Future<List<Map<String, dynamic>>> obtenerEventosCalendarioPorMes(
      int year, int month) async {
    try {
      final inicioMes = DateTime(year, month, 1);
      final finMes = DateTime(year, month + 1, 0, 23, 59, 59);

      final snapshot = await _firestore
          .collection('calendario_academico')
          .where('visible', isEqualTo: true)
          .where('fecha_inicio',
              isGreaterThanOrEqualTo: Timestamp.fromDate(inicioMes))
          .where('fecha_inicio',
              isLessThanOrEqualTo: Timestamp.fromDate(finMes))
          .orderBy('fecha_inicio')
          .get();

      return snapshot.docs.map((doc) {
        var data = doc.data();
        data['id'] = doc.id;
        return data;
      }).toList();
    } catch (e) {
      print('Error al obtener eventos de calendario: $e');
      return [];
    }
  }

  // ==================== HORARIOS ====================

  // Obtener horarios de un estudiante
  Stream<List<Map<String, dynamic>>> obtenerHorarios(String carnet) {
    return _firestore
        .collection('horarios')
        .doc(carnet)
        .collection('clases')
        .orderBy('dia')
        .orderBy('hora_inicio')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        var data = doc.data();
        data['id'] = doc.id;
        return data;
      }).toList();
    });
  }
}
