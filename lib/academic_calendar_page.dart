import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loyola_app22/services/auth_service.dart';
import 'package:google_fonts/google_fonts.dart';

class AcademicCalendarPage extends StatefulWidget {
  const AcademicCalendarPage({Key? key}) : super(key: key);

  static String routeName = 'AcademicCalendarPage';
  static String routePath = '/academicCalendarPage';

  @override
  State<AcademicCalendarPage> createState() => _AcademicCalendarPageState();
}

class _AcademicCalendarPageState extends State<AcademicCalendarPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final AuthService _authService = AuthService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Map<DateTime, List<Map<String, dynamic>>> _events = {};
  bool _cargando = true;

  @override
  void initState() {
    super.initState();
    _cargarEventos();
  }

  Future<void> _cargarEventos() async {
    try {
      final carnet = await _authService.obtenerCarnetActual();
      if (carnet == null) return;

      final querySnapshot = await _firestore
          .collection('estudiantes')
          .where('numeroCarnet', isEqualTo: carnet)
          .limit(1)
          .get();

      if (querySnapshot.docs.isEmpty) return;

      final estudianteId = querySnapshot.docs.first.id;

      final eventosSnapshot = await _firestore
          .collection('estudiantes')
          .doc(estudianteId)
          .collection('eventos')
          .get();

      Map<DateTime, List<Map<String, dynamic>>> eventosMap = {};

      for (var doc in eventosSnapshot.docs) {
        final data = doc.data();
        final fecha = (data['fecha'] as Timestamp).toDate();
        final fechaSinHora = DateTime(fecha.year, fecha.month, fecha.day);

        if (!eventosMap.containsKey(fechaSinHora)) {
          eventosMap[fechaSinHora] = [];
        }

        eventosMap[fechaSinHora]!.add({
          'id': doc.id,
          'titulo': data['titulo'] ?? '',
          'tipo': data['tipo'] ?? 'Evento',
          'descripcion': data['descripcion'] ?? '',
          'fecha': fecha,
        });
      }

      setState(() {
        _events = eventosMap;
        _cargando = false;
      });
    } catch (e) {
      print('Error cargando eventos: $e');
      setState(() {
        _cargando = false;
      });
    }
  }

  Color getEventColor(String tipo) {
    switch (tipo.toLowerCase()) {
      case 'examen':
        return Color(0xFF8C1D40);
      case 'clase':
        return Color(0xFF31B9C5);
      case 'evento':
        return Color(0xFF02CA79);
      case 'reunion':
        return Color(0xFFFF9800);
      case 'feriado':
        return Color(0xFF4CAF50);
      default:
        return Colors.grey;
    }
  }

  List<Map<String, dynamic>> getEventsForDay(DateTime day) {
    final fechaSinHora = DateTime(day.year, day.month, day.day);
    return _events[fechaSinHora] ?? [];
  }

  Future<void> _mostrarDialogoCrearEvento(BuildContext context) async {
    final tituloController = TextEditingController();
    final descripcionController = TextEditingController();
    DateTime fechaSeleccionada = _selectedDay ?? DateTime.now();
    String tipoSeleccionado = 'Evento';

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text(
                'Agregar Evento',
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: tituloController,
                      decoration: InputDecoration(
                        labelText: 'Título',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 12),
                    TextField(
                      controller: descripcionController,
                      decoration: InputDecoration(
                        labelText: 'Descripción',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 2,
                    ),
                    SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      value: tipoSeleccionado,
                      decoration: InputDecoration(
                        labelText: 'Tipo de Evento',
                        border: OutlineInputBorder(),
                      ),
                      items: [
                        DropdownMenuItem(
                            value: 'Evento', child: Text('Evento')),
                        DropdownMenuItem(
                            value: 'Examen', child: Text('Examen')),
                        DropdownMenuItem(value: 'Clase', child: Text('Clase')),
                        DropdownMenuItem(
                            value: 'Reunion', child: Text('Reunión')),
                        DropdownMenuItem(
                            value: 'Feriado', child: Text('Feriado')),
                      ],
                      onChanged: (value) {
                        setDialogState(() {
                          tipoSeleccionado = value!;
                        });
                      },
                    ),
                    SizedBox(height: 12),
                    ListTile(
                      title: Text('Fecha'),
                      subtitle: Text(
                          '${fechaSeleccionada.day}/${fechaSeleccionada.month}/${fechaSeleccionada.year}'),
                      trailing: Icon(Icons.calendar_today),
                      onTap: () async {
                        final fecha = await showDatePicker(
                          context: context,
                          initialDate: fechaSeleccionada,
                          firstDate: DateTime(2024),
                          lastDate: DateTime(2026),
                        );
                        if (fecha != null) {
                          setDialogState(() {
                            fechaSeleccionada = fecha;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancelar'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF8C1D40),
                  ),
                  onPressed: () async {
                    if (tituloController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('El título es obligatorio')),
                      );
                      return;
                    }

                    await _guardarEvento(
                      tituloController.text,
                      descripcionController.text,
                      tipoSeleccionado,
                      fechaSeleccionada,
                    );

                    // CERRAR DIALOG DE AGREGAR EVENTO
                    Navigator.of(context).pop();

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Evento agregado exitosamente'),
                        backgroundColor: Color(0xFF02CA79),
                      ),
                    );
                  },
                  child: Text('Guardar', style: TextStyle(color: Colors.white)),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _guardarEvento(
    String titulo,
    String descripcion,
    String tipo,
    DateTime fecha,
  ) async {
    try {
      final carnet = await _authService.obtenerCarnetActual();
      if (carnet == null) return;

      final querySnapshot = await _firestore
          .collection('estudiantes')
          .where('numeroCarnet', isEqualTo: carnet)
          .limit(1)
          .get();

      if (querySnapshot.docs.isEmpty) return;

      final estudianteId = querySnapshot.docs.first.id;

      await _firestore
          .collection('estudiantes')
          .doc(estudianteId)
          .collection('eventos')
          .add({
        'titulo': titulo,
        'descripcion': descripcion,
        'tipo': tipo,
        'fecha': Timestamp.fromDate(fecha),
        'creadoEn': FieldValue.serverTimestamp(),
      });

      await _cargarEventos();
    } catch (e) {
      print('Error guardando evento: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_cargando) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF8C1D40),
          title: Text(
            'Calendario Académico',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: Center(
          child: CircularProgressIndicator(color: Color(0xFF8C1D40)),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF8C1D40),
        title: Text(
          'Calendario Académico',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.white),
            onPressed: () => _mostrarDialogoCrearEvento(context),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            child: Column(
              children: [
                Text(
                  'Mantente al día con tu recorrido académico',
                  style: TextStyle(color: Colors.black87, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildLegend('Exámenes', getEventColor('Examen')),
                    SizedBox(width: 12),
                    _buildLegend('Eventos', getEventColor('Evento')),
                    SizedBox(width: 12),
                    _buildLegend('Clases', getEventColor('Clase')),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.5,
            child: TableCalendar(
              firstDay: DateTime.utc(2024, 1, 1),
              lastDay: DateTime.utc(2026, 12, 31),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              calendarFormat: CalendarFormat.month,
              locale: 'es_ES',
              eventLoader: (day) => getEventsForDay(day),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              calendarBuilders: CalendarBuilders(
                markerBuilder: (context, date, events) {
                  final eventosDelDia = getEventsForDay(date);
                  if (eventosDelDia.isEmpty) return SizedBox();

                  return Positioned(
                    bottom: 4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: eventosDelDia.take(3).map((evento) {
                        return Container(
                          width: 6,
                          height: 6,
                          margin: EdgeInsets.symmetric(horizontal: 1),
                          decoration: BoxDecoration(
                            color: getEventColor(evento['tipo'] ?? 'Evento'),
                            shape: BoxShape.circle,
                          ),
                        );
                      }).toList(),
                    ),
                  );
                },
              ),
              headerStyle: HeaderStyle(
                titleCentered: true,
                formatButtonVisible: false,
                titleTextStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF8C1D40),
                ),
                leftChevronIcon: Icon(
                  Icons.chevron_left,
                  color: Color(0xFF8C1D40),
                ),
                rightChevronIcon: Icon(
                  Icons.chevron_right,
                  color: Color(0xFF8C1D40),
                ),
              ),
              daysOfWeekStyle: DaysOfWeekStyle(
                weekendStyle: TextStyle(color: Colors.black54),
              ),
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Color(0xFF8C1D40),
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Color(0xFF31B9C5),
                  shape: BoxShape.circle,
                ),
                markerDecoration: BoxDecoration(
                  color: Color(0xFF02CA79),
                  shape: BoxShape.circle,
                ),
                holidayTextStyle: TextStyle(color: Colors.green),
              ),
            ),
          ),
          SizedBox(height: 12),
          _selectedDay != null
              ? Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: _buildEventsList(_selectedDay!),
                  ),
                )
              : SizedBox(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF8C1D40),
        onPressed: () => _mostrarDialogoCrearEvento(context),
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildEventsList(DateTime day) {
    List<Map<String, dynamic>> events = getEventsForDay(day);
    if (events.isEmpty) {
      return Center(
        child: Text(
          "No hay eventos para este día.",
          style: TextStyle(fontSize: 16, color: Colors.black54),
        ),
      );
    }
    return ListView.builder(
      itemCount: events.length,
      itemBuilder: (context, index) {
        final evento = events[index];
        String tipo = evento['tipo'] ?? 'Evento';
        String titulo = evento['titulo'] ?? '';
        String descripcion = evento['descripcion'] ?? '';

        return Card(
          elevation: 2,
          margin: EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: getEventColor(tipo).withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _getIconForType(tipo),
                color: getEventColor(tipo),
                size: 20,
              ),
            ),
            title: Text(
              titulo,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${day.day} ${_monthName(day.month)} ${day.year}"),
                if (descripcion.isNotEmpty)
                  Text(
                    descripcion,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
            trailing: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: getEventColor(tipo).withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                tipo,
                style: TextStyle(
                  color: getEventColor(tipo),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  IconData _getIconForType(String tipo) {
    switch (tipo.toLowerCase()) {
      case 'examen':
        return Icons.quiz;
      case 'clase':
        return Icons.school;
      case 'evento':
        return Icons.event;
      case 'reunion':
        return Icons.groups;
      case 'feriado':
        return Icons.celebration;
      default:
        return Icons.event_note;
    }
  }

  String _monthName(int month) {
    const months = [
      "",
      "Enero",
      "Febrero",
      "Marzo",
      "Abril",
      "Mayo",
      "Junio",
      "Julio",
      "Agosto",
      "Septiembre",
      "Octubre",
      "Noviembre",
      "Diciembre",
    ];
    return months[month];
  }

  Widget _buildLegend(String text, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 4),
        Text(text, style: TextStyle(fontSize: 14)),
      ],
    );
  }
}
