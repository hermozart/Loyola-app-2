import 'package:loyola_app22/app_components/app_drop_down.dart';
import 'package:loyola_app22/app_components/app_icon_button.dart';
import 'package:loyola_app22/app_components/app_theme.dart';
import 'package:loyola_app22/app_components/app_util.dart';
import 'package:loyola_app22/app_components/app_widgets.dart';
import 'package:loyola_app22/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loyola_app22/app_components/form_field_controller.dart';
import 'package:provider/provider.dart';

import 'schedule_page_model.dart';
export 'schedule_page_model.dart';

class HorariosPageWidget extends StatefulWidget {
  const HorariosPageWidget({super.key});

  static String routeName = 'HorariosPage';
  static String routePath = '/horariosPage';

  @override
  State<HorariosPageWidget> createState() => _HorariosPageWidgetState();
}

class _HorariosPageWidgetState extends State<HorariosPageWidget> {
  late HorariosPageModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final AuthService _authService = AuthService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Map<String, dynamic>> _horarios = [];
  String _diaSeleccionado = 'Hoy';
  bool _cargando = true;

  final Map<int, String> _nombresDias = {
    1: 'Lunes',
    2: 'Martes',
    3: 'Miércoles',
    4: 'Jueves',
    5: 'Viernes',
    6: 'Sábado',
    7: 'Domingo',
  };

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HorariosPageModel());
    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();
    _cargarHorarios();
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  Future<void> _cargarHorarios() async {
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

      final horariosSnapshot = await _firestore
          .collection('estudiantes')
          .doc(estudianteId)
          .collection('horarios')
          .orderBy('diaNumero')
          .orderBy('horaInicio')
          .get();

      List<Map<String, dynamic>> horariosList = [];

      for (var doc in horariosSnapshot.docs) {
        final data = doc.data();
        horariosList.add({
          'id': doc.id,
          'nombreMateria': data['nombreMateria'] ?? '',
          'aula': data['aula'] ?? '',
          'horaInicio': data['horaInicio'] ?? '',
          'horaFin': data['horaFin'] ?? '',
          'diaNombre': data['diaNombre'] ?? '',
          'diaNumero': data['diaNumero'] ?? 0,
        });
      }

      setState(() {
        _horarios = horariosList;
        _cargando = false;
      });
    } catch (e) {
      print('Error cargando horarios: $e');
      setState(() {
        _cargando = false;
      });
    }
  }

  List<Map<String, dynamic>> _filtrarHorariosPorDia() {
    if (_diaSeleccionado == 'Hoy') {
      final diaActual = DateTime.now().weekday;
      return _horarios.where((h) => h['diaNumero'] == diaActual).toList();
    }
    return _horarios.where((h) => h['diaNombre'] == _diaSeleccionado).toList();
  }

  bool _esClaseEnProgreso(String horaInicio, String horaFin) {
    try {
      final ahora = DateTime.now();
      final horaActual = ahora.hour * 60 + ahora.minute;

      final inicioPartes = horaInicio.split(':');
      final finPartes = horaFin.split(':');

      final minutoInicio =
          int.parse(inicioPartes[0]) * 60 + int.parse(inicioPartes[1]);
      final minutoFin = int.parse(finPartes[0]) * 60 + int.parse(finPartes[1]);

      return horaActual >= minutoInicio && horaActual <= minutoFin;
    } catch (e) {
      return false;
    }
  }

  String _obtenerAbreviaturaDia(String diaNombre) {
    switch (diaNombre) {
      case 'Lunes':
        return 'LUN';
      case 'Martes':
        return 'MAR';
      case 'Miércoles':
        return 'MIÉ';
      case 'Jueves':
        return 'JUE';
      case 'Viernes':
        return 'VIE';
      case 'Sábado':
        return 'SÁB';
      case 'Domingo':
        return 'DOM';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_cargando) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF8C1D40),
          title: Text('Horarios', style: TextStyle(color: Colors.white)),
          centerTitle: false,
        ),
        body: Center(
          child: CircularProgressIndicator(color: Color(0xFF8C1D40)),
        ),
      );
    }

    final horariosFiltrados = _filtrarHorariosPorDia();
    final diaActual = DateTime.now().day;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: AppTheme.of(context).secondaryBackground,
        appBar: AppBar(
          backgroundColor: Color(0xFF8C1D40),
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Align(
                  alignment: AlignmentDirectional(0, 0),
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      'L',
                      textAlign: TextAlign.center,
                      style: AppTheme.of(context).titleMedium.override(
                            font: GoogleFonts.interTight(
                              fontWeight: FontWeight.bold,
                              fontStyle:
                                  AppTheme.of(context).titleMedium.fontStyle,
                            ),
                            color: Color(0xFF8C1D40),
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.bold,
                            fontStyle:
                                AppTheme.of(context).titleMedium.fontStyle,
                          ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12),
              Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'LoyolaApp',
                    style: AppTheme.of(context).titleLarge.override(
                          font: GoogleFonts.interTight(
                            fontWeight: FontWeight.bold,
                            fontStyle:
                                AppTheme.of(context).titleLarge.fontStyle,
                          ),
                          color: Colors.white,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.bold,
                          fontStyle: AppTheme.of(context).titleLarge.fontStyle,
                        ),
                  ),
                  Text(
                    'Portal Estudiantil',
                    style: AppTheme.of(context).bodySmall.override(
                          font: GoogleFonts.inter(
                            fontWeight:
                                AppTheme.of(context).bodySmall.fontWeight,
                            fontStyle: AppTheme.of(context).bodySmall.fontStyle,
                          ),
                          color: Color(0xCCFFFFFF),
                          letterSpacing: 0.0,
                          fontWeight: AppTheme.of(context).bodySmall.fontWeight,
                          fontStyle: AppTheme.of(context).bodySmall.fontStyle,
                        ),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  AppIconButton(
                    borderRadius: 20,
                    buttonSize: 40,
                    fillColor: Color(0x1AFFFFFF),
                    icon: Icon(
                      Icons.calendar_today_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                    onPressed: () {
                      print('Calendario presionado');
                    },
                  ),
                  SizedBox(width: 8),
                  AppIconButton(
                    borderRadius: 20,
                    buttonSize: 40,
                    fillColor: Color(0x1AFFFFFF),
                    icon: Icon(
                      Icons.notifications_outlined,
                      color: Colors.white,
                      size: 20,
                    ),
                    onPressed: () {
                      print('Notificaciones presionadas');
                    },
                  ),
                ],
              ),
            ),
          ],
          centerTitle: false,
          elevation: 0,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: double.infinity,
                height: 120,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF8C1D40), Color(0xFFB8344A)],
                    stops: [0, 1],
                    begin: AlignmentDirectional(1, 0),
                    end: AlignmentDirectional(-1, 0),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Horario de Clases',
                        style: AppTheme.of(context).headlineLarge.override(
                              font: GoogleFonts.interTight(
                                fontWeight: FontWeight.bold,
                                fontStyle: AppTheme.of(context)
                                    .headlineLarge
                                    .fontStyle,
                              ),
                              color: Colors.white,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.bold,
                              fontStyle:
                                  AppTheme.of(context).headlineLarge.fontStyle,
                            ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                        child: Text(
                          'Semestre 2024-2 • ${_nombresDias[DateTime.now().weekday]}',
                          style: AppTheme.of(context).bodyMedium.override(
                                font: GoogleFonts.inter(
                                  fontWeight: AppTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle:
                                      AppTheme.of(context).bodyMedium.fontStyle,
                                ),
                                color: Color(0xCCFFFFFF),
                                letterSpacing: 0.0,
                                fontWeight:
                                    AppTheme.of(context).bodyMedium.fontWeight,
                                fontStyle:
                                    AppTheme.of(context).bodyMedium.fontStyle,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppTheme.of(context).secondaryBackground,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: TextFormField(
                            controller: _model.textController,
                            focusNode: _model.textFieldFocusNode,
                            autofocus: false,
                            obscureText: false,
                            decoration: InputDecoration(
                              hintText: 'Buscar clases...',
                              hintStyle: AppTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font: GoogleFonts.inter(
                                      fontWeight: AppTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: AppTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: AppTheme.of(context).secondaryText,
                                    letterSpacing: 0.0,
                                    fontWeight: AppTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: AppTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppTheme.of(context).alternate,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFF8C1D40),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              filled: true,
                              fillColor: AppTheme.of(context).primaryBackground,
                              contentPadding: EdgeInsetsDirectional.fromSTEB(
                                  16, 12, 16, 12),
                              prefixIcon: Icon(
                                Icons.search_rounded,
                                color: AppTheme.of(context).secondaryText,
                                size: 20,
                              ),
                            ),
                            style: AppTheme.of(context).bodyMedium.override(
                                  font: GoogleFonts.inter(
                                    fontWeight: AppTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: AppTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                                  letterSpacing: 0.0,
                                  fontWeight: AppTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle:
                                      AppTheme.of(context).bodyMedium.fontStyle,
                                ),
                            cursorColor: Color(0xFF8C1D40),
                            validator: _model.textControllerValidator
                                .asValidator(context),
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          flex: 1,
                          child: AppDropDown<String>(
                            controller: _model.dropDownValueController ??=
                                FormFieldController<String>(null),
                            options: [
                              'Lunes',
                              'Martes',
                              'Miércoles',
                              'Jueves',
                              'Viernes',
                              'Sábado'
                            ],
                            onChanged: (val) {
                              setState(() {
                                _diaSeleccionado = val ?? 'Hoy';
                                _model.dropDownValue = val;
                              });
                            },
                            width: 100,
                            height: 48,
                            textStyle: AppTheme.of(context).bodyMedium.override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FontWeight.w600,
                                    fontStyle: AppTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                  fontStyle:
                                      AppTheme.of(context).bodyMedium.fontStyle,
                                ),
                            hintText: 'Hoy',
                            icon: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: AppTheme.of(context).secondaryText,
                              size: 12,
                            ),
                            fillColor: AppTheme.of(context).primaryBackground,
                            elevation: 0,
                            borderColor: AppTheme.of(context).alternate,
                            borderWidth: 1,
                            borderRadius: 12,
                            margin: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                            hidesUnderline: true,
                            isSearchable: false,
                            isMultiSelect: false,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: horariosFiltrados.isEmpty
                    ? Center(
                        child: Text(
                          'No hay clases para este día',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      )
                    : Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: horariosFiltrados.length,
                          itemBuilder: (context, index) {
                            final horario = horariosFiltrados[index];
                            final esEnProgreso = _esClaseEnProgreso(
                              horario['horaInicio'],
                              horario['horaFin'],
                            );

                            return _buildClassCard(
                              context,
                              horario['nombreMateria'],
                              'Aula ${horario['aula']}',
                              '${horario['horaInicio']} - ${horario['horaFin']}',
                              'Aula ${horario['aula']}',
                              '',
                              _obtenerAbreviaturaDia(horario['diaNombre']),
                              diaActual.toString(),
                              esEnProgreso,
                              esEnProgreso ? 'En Progreso' : 'Próximamente',
                              esEnProgreso
                                  ? Icons.circle_rounded
                                  : Icons.schedule_rounded,
                            );
                          },
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildClassCard(
    BuildContext context,
    String className,
    String classCode,
    String time,
    String location,
    String professor,
    String dayAbbr,
    String dayNumber,
    bool isActive,
    String statusText,
    IconData statusIcon,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppTheme.of(context).primaryBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color:
                isActive ? Color(0xFF8C1D40) : AppTheme.of(context).alternate,
            width: isActive ? 2 : 1,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          className,
                          style: AppTheme.of(context).titleMedium.override(
                                font: GoogleFonts.interTight(
                                  fontWeight: FontWeight.bold,
                                  fontStyle: AppTheme.of(context)
                                      .titleMedium
                                      .fontStyle,
                                ),
                                color: isActive
                                    ? Color(0xFF8C1D40)
                                    : AppTheme.of(context).primaryText,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.bold,
                                fontStyle:
                                    AppTheme.of(context).titleMedium.fontStyle,
                              ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
                          child: Text(
                            classCode,
                            style: AppTheme.of(context).bodyMedium.override(
                                  font: GoogleFonts.inter(
                                    fontWeight: AppTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: AppTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                                  color: AppTheme.of(context).secondaryText,
                                  letterSpacing: 0.0,
                                  fontWeight: AppTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle:
                                      AppTheme.of(context).bodyMedium.fontStyle,
                                ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Icon(
                                Icons.access_time_rounded,
                                color: AppTheme.of(context).secondaryText,
                                size: 16,
                              ),
                              SizedBox(width: 8),
                              Text(
                                time,
                                style: AppTheme.of(context).bodySmall.override(
                                      font: GoogleFonts.inter(
                                        fontWeight: AppTheme.of(context)
                                            .bodySmall
                                            .fontWeight,
                                        fontStyle: AppTheme.of(context)
                                            .bodySmall
                                            .fontStyle,
                                      ),
                                      color: AppTheme.of(context).secondaryText,
                                      letterSpacing: 0.0,
                                      fontWeight: AppTheme.of(context)
                                          .bodySmall
                                          .fontWeight,
                                      fontStyle: AppTheme.of(context)
                                          .bodySmall
                                          .fontStyle,
                                    ),
                              ),
                              SizedBox(width: 8),
                              Icon(
                                Icons.location_on_outlined,
                                color: AppTheme.of(context).secondaryText,
                                size: 16,
                              ),
                              SizedBox(width: 8),
                              Text(
                                location,
                                style: AppTheme.of(context).bodySmall.override(
                                      font: GoogleFonts.inter(
                                        fontWeight: AppTheme.of(context)
                                            .bodySmall
                                            .fontWeight,
                                        fontStyle: AppTheme.of(context)
                                            .bodySmall
                                            .fontStyle,
                                      ),
                                      color: AppTheme.of(context).secondaryText,
                                      letterSpacing: 0.0,
                                      fontWeight: AppTheme.of(context)
                                          .bodySmall
                                          .fontWeight,
                                      fontStyle: AppTheme.of(context)
                                          .bodySmall
                                          .fontStyle,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 12),
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: isActive
                          ? Color(0xFF8C1D40)
                          : AppTheme.of(context).secondaryText,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          dayAbbr,
                          textAlign: TextAlign.center,
                          style: AppTheme.of(context).titleSmall.override(
                                font: GoogleFonts.interTight(
                                  fontWeight: FontWeight.w600,
                                  fontStyle:
                                      AppTheme.of(context).titleSmall.fontStyle,
                                ),
                                color: Colors.white,
                                fontSize: 10,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                                fontStyle:
                                    AppTheme.of(context).titleSmall.fontStyle,
                              ),
                        ),
                        Text(
                          dayNumber,
                          textAlign: TextAlign.center,
                          style: AppTheme.of(context).headlineSmall.override(
                                font: GoogleFonts.interTight(
                                  fontWeight: FontWeight.bold,
                                  fontStyle: AppTheme.of(context)
                                      .headlineSmall
                                      .fontStyle,
                                ),
                                color: Colors.white,
                                fontSize: 18,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.bold,
                                fontStyle: AppTheme.of(context)
                                    .headlineSmall
                                    .fontStyle,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (professor.isNotEmpty) ...[
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 8),
                  child: Divider(
                    height: 1,
                    thickness: 1,
                    color: AppTheme.of(context).alternate,
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      professor,
                      style: AppTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.inter(
                              fontWeight: FontWeight.w500,
                              fontStyle:
                                  AppTheme.of(context).bodyMedium.fontStyle,
                            ),
                            color: AppTheme.of(context).primaryText,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w500,
                            fontStyle:
                                AppTheme.of(context).bodyMedium.fontStyle,
                          ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Icon(
                          statusIcon,
                          color: isActive
                              ? Color(0xFF8C1D40)
                              : AppTheme.of(context).secondaryText,
                          size: 16,
                        ),
                        SizedBox(width: 4),
                        Text(
                          statusText,
                          style: AppTheme.of(context).bodySmall.override(
                                font: GoogleFonts.inter(
                                  fontWeight: FontWeight.w600,
                                  fontStyle:
                                      AppTheme.of(context).bodySmall.fontStyle,
                                ),
                                color: isActive
                                    ? Color(0xFF8C1D40)
                                    : AppTheme.of(context).secondaryText,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                                fontStyle:
                                    AppTheme.of(context).bodySmall.fontStyle,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
