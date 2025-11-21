import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

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

  final Map<DateTime, List<String>> _events = {
    DateTime(2024, 12, 12): ['Examen'],
    DateTime(2024, 12, 15): ['Examen'],
    DateTime(2024, 12, 18): ['Evento'],
    DateTime(2024, 12, 25): ['Feriado'],
    DateTime(2024, 12, 31): ['Feriado'],
  };

  Color getEventColor(String tipo) {
    switch (tipo) {
      case 'Examen':
        return Color(0xFF8C1D40);
      case 'Evento':
        return Color(0xFF31B9C5);
      case 'Feriado':
        return Color(0xFF02CA79);
      default:
        return Colors.grey;
    }
  }

  List<String> getEventsForDay(DateTime day) {
    return _events[DateTime(day.year, day.month, day.day)] ?? [];
  }

  @override
  Widget build(BuildContext context) {
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
                    _buildLegend('Feriados', getEventColor('Feriado')),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: TableCalendar(
              firstDay: DateTime.utc(2025, 12, 1),
              lastDay: DateTime.utc(2026, 12, 31),
              // focusedDay: _focusedDay,
              focusedDay: DateTime.utc(2025, 12, 1),
              // selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              calendarFormat: CalendarFormat.month,
              locale: 'es_ES',
              eventLoader: getEventsForDay,
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              calendarBuilders: CalendarBuilders(
                markerBuilder: (context, date, events) {
                  if (events.isEmpty) return SizedBox();
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: events.map((e) {
                      return Container(
                        width: 20,
                        height: 20,
                        margin: EdgeInsets.symmetric(horizontal: 1),
                        decoration: BoxDecoration(
                          color: getEventColor(e.toString()),
                          shape: BoxShape.circle,
                        ),
                      );
                    }).toList(),
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
              : Expanded(child: Container()),
        ],
      ),
    );
  }

  Widget _buildEventsList(DateTime day) {
    List<String> events = getEventsForDay(day);
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
        String tipo = events[index];
        return Card(
          elevation: 2,
          margin: EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: Icon(Icons.event, color: getEventColor(tipo)),
            title: Text(
              tipo,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text("${day.day} ${_monthName(day.month)} ${day.year}"),
          ),
        );
      },
    );
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
