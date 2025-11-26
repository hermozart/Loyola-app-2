import 'package:loyola_app22/app_components/app_theme.dart';
import 'package:loyola_app22/app_components/app_util.dart';
import 'package:loyola_app22/app_components/app_widgets.dart';
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

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GradesPageModel());
    SchedulerBinding.instance.addPostFrameCallback((_) async {});
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                                  '4.2',
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
                                  '12',
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
                                  '1',
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
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFA7173B),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
                              child: Text(
                                'Todas',
                                style: AppTheme.of(context).bodyMedium.override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FontWeight.w600,
                                        fontStyle: AppTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      color: Colors.white,
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
                          SizedBox(width: 12),
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFF6F6F6),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Color(0xFFE0E3E7),
                                width: 1,
                              ),
                            ),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
                              child: Text(
                                '2025-1',
                                style: AppTheme.of(context).bodyMedium.override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FontWeight.w500,
                                        fontStyle: AppTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      color: Color(0xFF12151C),
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
                          SizedBox(width: 12),
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFF6F6F6),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Color(0xFFE0E3E7),
                                width: 1,
                              ),
                            ),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
                              child: Text(
                                '2024-2',
                                style: AppTheme.of(context).bodyMedium.override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FontWeight.w500,
                                        fontStyle: AppTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      color: Color(0xFF12151C),
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
                          SizedBox(width: 12),
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFF6F6F6),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Color(0xFFE0E3E7),
                                width: 1,
                              ),
                            ),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
                              child: Text(
                                '2024-1',
                                style: AppTheme.of(context).bodyMedium.override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FontWeight.w500,
                                        fontStyle: AppTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      color: Color(0xFF12151C),
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
                        ],
                      ),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      _buildGradeCard(
                        context,
                        'Cálculo Diferencial',
                        'Dr. García Martínez • Paralelo A',
                        0.7,
                        '70/100 puntos',
                        '4.5',
                        Color(0xFF02CA79),
                      ),
                      _buildGradeCard(
                        context,
                        'Física General',
                        'Dra. López Silva • Paralelo B',
                        0.85,
                        '85/100 puntos',
                        '4.8',
                        Color(0xFF02CA79),
                      ),
                      _buildGradeCard(
                        context,
                        'Programación I',
                        'Ing. Rodríguez Pérez • Paralelo C',
                        0.92,
                        '92/100 puntos',
                        '5.0',
                        Color(0xFF02CA79),
                      ),
                      _buildGradeCard(
                        context,
                        'Química Orgánica',
                        'Dr. Morales Castro • Paralelo A',
                        0.45,
                        '45/100 puntos',
                        '2.8',
                        Color(0xFFE65454),
                      ),
                      _buildGradeCard(
                        context,
                        'Historia Universal',
                        'Lic. Fernández Ruiz • Paralelo D',
                        0.78,
                        '78/100 puntos',
                        '4.3',
                        Color(0xFF02CA79),
                      ),
                    ],
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
