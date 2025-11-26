import 'package:loyola_app22/app_components/app_theme.dart';
import 'package:loyola_app22/app_components/app_util.dart';
import 'package:loyola_app22/app_components/app_widgets.dart';
import 'package:loyola_app22/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

import 'grades_page_model.dart';
export 'grades_page_model.dart';

class GradesPageWidget extends StatefulWidget {
  const GradesPageWidget({super.key});

  static String routeName = 'GradesPage';
  static String routePath = '/gradesPage';

  @override
  State<GradesPageWidget> createState() => _GradesPageWidgetState();
}

class _GradesPageWidgetState extends State<GradesPageWidget> {
  late GradesPageModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final AuthService _authService = AuthService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Map<String, dynamic>> _materias = [];
  String _periodoSeleccionado = 'Todas';
  bool _cargando = true;
  double _promedio = 0.0;
  int _aprobadas = 0;
  int _reprobadas = 0;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GradesPageModel());
    _cargarNotas();
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  Future<void> _cargarNotas() async {
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

      final materiasSnapshot = await _firestore
          .collection('estudiantes')
          .doc(estudianteId)
          .collection('materias')
          .get();

      List<Map<String, dynamic>> materiasList = [];
      double sumaNotas = 0;
      int totalCreditos = 0;
      int aprobadas = 0;
      int reprobadas = 0;

      for (var doc in materiasSnapshot.docs) {
        final data = doc.data();
        final nota = (data['nota_final'] ?? 0).toDouble();
        final int creditos = (data['creditos'] ?? 0).toInt();
        final estado = data['estado'] ?? '';

        materiasList.add({
          'id': doc.id,
          'nombre_materia': data['nombre_materia'] ?? '',
          'codigo_materia': data['codigo_materia'] ?? '',
          'nota_final': nota,
          'creditos': creditos,
          'periodo': data['periodo'] ?? '',
          'estado': estado,
          'docente': data['docente'] ?? '',
        });

        sumaNotas += nota * creditos;
        totalCreditos += creditos;

        if (estado.toLowerCase() == 'aprobado') {
          aprobadas++;
        } else if (estado.toLowerCase() == 'reprobado') {
          reprobadas++;
        }
      }

      final promedio = totalCreditos > 0 ? sumaNotas / totalCreditos : 0.0;

      setState(() {
        _materias = materiasList;
        _promedio = promedio;
        _aprobadas = aprobadas;
        _reprobadas = reprobadas;
        _cargando = false;
      });
    } catch (e) {
      print('Error cargando notas: $e');
      setState(() {
        _cargando = false;
      });
    }
  }

  List<Map<String, dynamic>> _filtrarMateriasPorPeriodo() {
    if (_periodoSeleccionado == 'Todas') {
      return _materias;
    }
    return _materias
        .where((m) => m['periodo'] == _periodoSeleccionado)
        .toList();
  }

  List<String> _obtenerPeriodosUnicos() {
    final periodos =
        _materias.map((m) => m['periodo'] as String).toSet().toList();
    periodos.sort((a, b) => b.compareTo(a)); // Más reciente primero
    return periodos;
  }

  @override
  Widget build(BuildContext context) {
    if (_cargando) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF8C1D2E),
          title: Text(
            'Calificaciones',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: CircularProgressIndicator(color: Color(0xFF8C1D2E)),
        ),
      );
    }

    final materiasFiltradas = _filtrarMateriasPorPeriodo();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color(0xFF8C1D2E),
          automaticallyImplyLeading: false,
          title: Text(
            'Calificaciones',
            style: AppTheme.of(context).titleLarge.override(
                  font: GoogleFonts.readexPro(
                    fontWeight: FontWeight.w600,
                    fontStyle: AppTheme.of(context).titleLarge.fontStyle,
                  ),
                  color: Colors.white,
                  fontSize: 22,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w600,
                  fontStyle: AppTheme.of(context).titleLarge.fontStyle,
                ),
          ),
          actions: [],
          centerTitle: true,
          elevation: 0,
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                    child: Text(
                      'Resumen',
                      style: AppTheme.of(context).titleMedium.override(
                            font: GoogleFonts.readexPro(
                              fontWeight: FontWeight.bold,
                              fontStyle:
                                  AppTheme.of(context).titleMedium.fontStyle,
                            ),
                            color: Colors.black,
                            fontSize: 18,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.bold,
                            fontStyle:
                                AppTheme.of(context).titleMedium.fontStyle,
                          ),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 4,
                                color: Color(0x1A000000),
                                offset: Offset(0.0, 2),
                              )
                            ],
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  _promedio.toStringAsFixed(1),
                                  textAlign: TextAlign.center,
                                  style: AppTheme.of(context)
                                      .headlineSmall
                                      .override(
                                        font: GoogleFonts.readexPro(
                                          fontWeight: FontWeight.bold,
                                          fontStyle: AppTheme.of(context)
                                              .headlineSmall
                                              .fontStyle,
                                        ),
                                        color: Color(0xFF12151C),
                                        fontSize: 20,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: AppTheme.of(context)
                                            .headlineSmall
                                            .fontStyle,
                                      ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Promedio',
                                  textAlign: TextAlign.center,
                                  style:
                                      AppTheme.of(context).bodySmall.override(
                                            font: GoogleFonts.inter(
                                              fontWeight: FontWeight.normal,
                                              fontStyle: AppTheme.of(context)
                                                  .bodySmall
                                                  .fontStyle,
                                            ),
                                            color: Color(0xFF5A5C60),
                                            fontSize: 12,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.normal,
                                            fontStyle: AppTheme.of(context)
                                                .bodySmall
                                                .fontStyle,
                                          ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Container(
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 4,
                                color: Color(0x1A000000),
                                offset: Offset(0.0, 2),
                              )
                            ],
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '$_aprobadas',
                                  textAlign: TextAlign.center,
                                  style: AppTheme.of(context)
                                      .headlineSmall
                                      .override(
                                        font: GoogleFonts.readexPro(
                                          fontWeight: FontWeight.bold,
                                          fontStyle: AppTheme.of(context)
                                              .headlineSmall
                                              .fontStyle,
                                        ),
                                        color: Color(0xFF02CA79),
                                        fontSize: 20,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: AppTheme.of(context)
                                            .headlineSmall
                                            .fontStyle,
                                      ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Aprobadas',
                                  textAlign: TextAlign.center,
                                  style:
                                      AppTheme.of(context).bodySmall.override(
                                            font: GoogleFonts.inter(
                                              fontWeight: FontWeight.normal,
                                              fontStyle: AppTheme.of(context)
                                                  .bodySmall
                                                  .fontStyle,
                                            ),
                                            color: Color(0xFF5A5C60),
                                            fontSize: 12,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.normal,
                                            fontStyle: AppTheme.of(context)
                                                .bodySmall
                                                .fontStyle,
                                          ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Container(
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 4,
                                color: Color(0x1A000000),
                                offset: Offset(0.0, 2),
                              )
                            ],
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '$_reprobadas',
                                  textAlign: TextAlign.center,
                                  style: AppTheme.of(context)
                                      .headlineSmall
                                      .override(
                                        font: GoogleFonts.readexPro(
                                          fontWeight: FontWeight.bold,
                                          fontStyle: AppTheme.of(context)
                                              .headlineSmall
                                              .fontStyle,
                                        ),
                                        color: Color(0xFFE65454),
                                        fontSize: 20,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: AppTheme.of(context)
                                            .headlineSmall
                                            .fontStyle,
                                      ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Reprobadas',
                                  textAlign: TextAlign.center,
                                  style:
                                      AppTheme.of(context).bodySmall.override(
                                            font: GoogleFonts.inter(
                                              fontWeight: FontWeight.normal,
                                              fontStyle: AppTheme.of(context)
                                                  .bodySmall
                                                  .fontStyle,
                                            ),
                                            color: Color(0xFF5A5C60),
                                            fontSize: 12,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.normal,
                                            fontStyle: AppTheme.of(context)
                                                .bodySmall
                                                .fontStyle,
                                          ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _periodoSeleccionado = 'Todas';
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: _periodoSeleccionado == 'Todas'
                                    ? Color(0xFFA7173B)
                                    : Color(0xFFF6F6F6),
                                borderRadius: BorderRadius.circular(20),
                                border: _periodoSeleccionado != 'Todas'
                                    ? Border.all(
                                        color: Color(0xFFE0E3E7),
                                        width: 1,
                                      )
                                    : null,
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16, 8, 16, 8),
                                child: Text(
                                  'Todas',
                                  style: AppTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        font: GoogleFonts.inter(
                                          fontWeight: FontWeight.w600,
                                          fontStyle: AppTheme.of(context)
                                              .bodyMedium
                                              .fontStyle,
                                        ),
                                        color: _periodoSeleccionado == 'Todas'
                                            ? Colors.white
                                            : Color(0xFF12151C),
                                        fontSize: 14,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                        fontStyle: AppTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                ),
                              ),
                            ),
                          ),
                          ..._obtenerPeriodosUnicos().map((periodo) {
                            return Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _periodoSeleccionado = periodo;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: _periodoSeleccionado == periodo
                                        ? Color(0xFFA7173B)
                                        : Color(0xFFF6F6F6),
                                    borderRadius: BorderRadius.circular(20),
                                    border: _periodoSeleccionado != periodo
                                        ? Border.all(
                                            color: Color(0xFFE0E3E7),
                                            width: 1,
                                          )
                                        : null,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16, 8, 16, 8),
                                    child: Text(
                                      periodo,
                                      style: AppTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight: FontWeight.w500,
                                              fontStyle: AppTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                            ),
                                            color:
                                                _periodoSeleccionado == periodo
                                                    ? Colors.white
                                                    : Color(0xFF12151C),
                                            fontSize: 14,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
                                            fontStyle: AppTheme.of(context)
                                                .bodyMedium
                                                .fontStyle,
                                          ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                  ),
                  materiasFiltradas.isEmpty
                      ? Center(
                          child: Padding(
                            padding: EdgeInsets.all(32),
                            child: Text(
                              'No hay materias registradas',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        )
                      : Column(
                          mainAxisSize: MainAxisSize.max,
                          children: materiasFiltradas.map((materia) {
                            final nota = materia['nota_final'] as double;
                            final nombre = materia['nombre_materia'] as String;
                            final docente = materia['docente'] as String;
                            final estado = materia['estado'] as String;
                            final progress = nota / 100;
                            final gradeColor =
                                estado.toLowerCase() == 'aprobado'
                                    ? Color(0xFF02CA79)
                                    : Color(0xFFE65454);

                            return _buildGradeCard(
                              context,
                              nombre,
                              docente,
                              progress,
                              '${nota.toInt()}/100 puntos',
                              nota.toStringAsFixed(0),
                              gradeColor,
                            );
                          }).toList(),
                        ),
                ]
                    .divide(SizedBox(height: 24))
                    .addToStart(SizedBox(height: 20))
                    .addToEnd(SizedBox(height: 20)),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGradeCard(
    BuildContext context,
    String courseName,
    String teacher,
    double progress,
    String progressText,
    String grade,
    Color gradeColor,
  ) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 6,
              color: Color(0x1A000000),
              offset: Offset(0.0, 3),
            )
          ],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      courseName,
                      style: AppTheme.of(context).titleMedium.override(
                            font: GoogleFonts.readexPro(
                              fontWeight: FontWeight.bold,
                              fontStyle:
                                  AppTheme.of(context).titleMedium.fontStyle,
                            ),
                            color: Colors.black,
                            fontSize: 18,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.bold,
                            fontStyle:
                                AppTheme.of(context).titleMedium.fontStyle,
                          ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      teacher,
                      style: AppTheme.of(context).bodySmall.override(
                            font: GoogleFonts.inter(
                              fontWeight: FontWeight.normal,
                              fontStyle:
                                  AppTheme.of(context).bodySmall.fontStyle,
                            ),
                            color: Color(0xFF5A5C60),
                            fontSize: 12,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.normal,
                            fontStyle: AppTheme.of(context).bodySmall.fontStyle,
                          ),
                    ),
                    SizedBox(height: 8),
                    LinearPercentIndicator(
                      percent: progress,
                      width: MediaQuery.sizeOf(context).width * 0.5,
                      lineHeight: 6,
                      animation: true,
                      animateFromLastPercent: true,
                      progressColor: Color(0xFF8C1D40),
                      backgroundColor: Color(0xFFE0E3E7),
                      padding: EdgeInsets.zero,
                    ),
                    SizedBox(height: 8),
                    Text(
                      progressText,
                      style: AppTheme.of(context).bodySmall.override(
                            font: GoogleFonts.inter(
                              fontWeight: FontWeight.normal,
                              fontStyle:
                                  AppTheme.of(context).bodySmall.fontStyle,
                            ),
                            color: Color(0xFF5A5C60),
                            fontSize: 12,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.normal,
                            fontStyle: AppTheme.of(context).bodySmall.fontStyle,
                          ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: gradeColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Align(
                  alignment: AlignmentDirectional(0, 0),
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      grade,
                      textAlign: TextAlign.center,
                      style: AppTheme.of(context).headlineMedium.override(
                            font: GoogleFonts.readexPro(
                              fontWeight: FontWeight.bold,
                              fontStyle:
                                  AppTheme.of(context).headlineMedium.fontStyle,
                            ),
                            color: Colors.white,
                            fontSize: 22,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.bold,
                            fontStyle:
                                AppTheme.of(context).headlineMedium.fontStyle,
                          ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
