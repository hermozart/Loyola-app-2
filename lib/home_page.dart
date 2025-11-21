import 'package:loyola_app22/app_components/app_animations.dart';
import 'package:loyola_app22/app_components/app_theme.dart';
import 'package:loyola_app22/app_components/app_util.dart';
import 'package:loyola_app22/app_components/app_widgets.dart';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'home_page_model.dart';
export 'home_page_model.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});

  static String routeName = 'HomePage';
  static String routePath = '/homePage';

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget>
    with TickerProviderStateMixin {
  late HomePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePageModel());

    animationsMap.addAll({
      'textOnPageLoadAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'textOnPageLoadAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'textOnPageLoadAnimation3': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'containerOnPageLoadAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 0.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'containerOnPageLoadAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 80.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'containerOnPageLoadAnimation3': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 160.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'containerOnPageLoadAnimation4': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 240.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'containerOnPageLoadAnimation5': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 320.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'containerOnPageLoadAnimation6': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 400.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
    });
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
        backgroundColor: Color(0xFF8C1D31),
        body: SafeArea(
          top: true,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF8C1D31), Color(0xFF330A14)],
                stops: [1, 1],
                begin: AlignmentDirectional(0, 1),
                end: AlignmentDirectional(0, -1),
              ),
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
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
                                'Hola, estudiante 👋',
                                style: AppTheme.of(context).titleLarge.override(
                                      font: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.bold,
                                        fontStyle: AppTheme.of(context)
                                            .titleLarge
                                            .fontStyle,
                                      ),
                                      color: Colors.white,
                                      fontSize: 22,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: AppTheme.of(context)
                                          .titleLarge
                                          .fontStyle,
                                    ),
                              ).animateOnPageLoad(
                                animationsMap['textOnPageLoadAnimation1']!,
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                  0,
                                  4,
                                  0,
                                  0,
                                ),
                                child: Text(
                                  '¿Qué necesitas hoy?',
                                  style:
                                      AppTheme.of(context).bodyMedium.override(
                                            font: GoogleFonts.nunitoSans(
                                              fontWeight: AppTheme.of(context)
                                                  .bodyMedium
                                                  .fontWeight,
                                              fontStyle: AppTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                            ),
                                            color: Color(0xCCFFFFFF),
                                            fontSize: 16,
                                            letterSpacing: 0.0,
                                            fontWeight: AppTheme.of(context)
                                                .bodyMedium
                                                .fontWeight,
                                            fontStyle: AppTheme.of(context)
                                                .bodyMedium
                                                .fontStyle,
                                          ),
                                ).animateOnPageLoad(
                                  animationsMap['textOnPageLoadAnimation2']!,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 50,
                          height: 50,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          child: Image.network(
                            'https://img.freepik.com/vector-premium/icono-membresia-plateado-icono-perfil-avatar-defecto-icono-miembros-imagen-usuario-redes-sociales-ilustracion-vectorial_561158-4215.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Accesos rápidos',
                          style: AppTheme.of(context).bodyMedium.override(
                                font: GoogleFonts.nunitoSans(
                                  fontWeight: FontWeight.w600,
                                  fontStyle:
                                      AppTheme.of(context).bodyMedium.fontStyle,
                                ),
                                color: Colors.white,
                                fontSize: 16,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                                fontStyle:
                                    AppTheme.of(context).bodyMedium.fontStyle,
                              ),
                        ).animateOnPageLoad(
                          animationsMap['textOnPageLoadAnimation3']!,
                        ),
                        GridView(
                          padding: EdgeInsets.zero,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 0.7,
                          ),
                          primary: false,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 8,
                                    color: Color(0x1A000000),
                                    offset: Offset(0.0, 2),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(16),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.grade_rounded,
                                      color: Color(0xFF8C1D40),
                                      size: 32,
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Calificaciones',
                                      textAlign: TextAlign.center,
                                      style: AppTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.nunitoSans(
                                              fontWeight: FontWeight.w500,
                                              fontStyle: AppTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                            ),
                                            color: Color(0xFF333333),
                                            fontSize: 14,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
                                            fontStyle: AppTheme.of(context)
                                                .bodyMedium
                                                .fontStyle,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ).animateOnPageLoad(
                              animationsMap['containerOnPageLoadAnimation1']!,
                            ),
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 8,
                                    color: Color(0x1A000000),
                                    offset: Offset(0.0, 2),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(16),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.schedule_rounded,
                                      color: Color(0xFF8C1D40),
                                      size: 32,
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Horarios',
                                      textAlign: TextAlign.center,
                                      style: AppTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.nunitoSans(
                                              fontWeight: FontWeight.w500,
                                              fontStyle: AppTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                            ),
                                            color: Color(0xFF333333),
                                            fontSize: 14,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
                                            fontStyle: AppTheme.of(context)
                                                .bodyMedium
                                                .fontStyle,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ).animateOnPageLoad(
                              animationsMap['containerOnPageLoadAnimation2']!,
                            ),
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 8,
                                    color: Color(0x1A000000),
                                    offset: Offset(0.0, 2),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(16),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.article_rounded,
                                      color: Color(0xFF8C1D40),
                                      size: 32,
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Noticias',
                                      textAlign: TextAlign.center,
                                      style: AppTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.nunitoSans(
                                              fontWeight: FontWeight.w500,
                                              fontStyle: AppTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                            ),
                                            color: Color(0xFF333333),
                                            fontSize: 14,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
                                            fontStyle: AppTheme.of(context)
                                                .bodyMedium
                                                .fontStyle,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ).animateOnPageLoad(
                              animationsMap['containerOnPageLoadAnimation3']!,
                            ),
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 8,
                                    color: Color(0x1A000000),
                                    offset: Offset(0.0, 2),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(16),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.calendar_today_rounded,
                                      color: Color(0xFF8C1D40),
                                      size: 32,
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Calendario',
                                      textAlign: TextAlign.center,
                                      style: AppTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.nunitoSans(
                                              fontWeight: FontWeight.w500,
                                              fontStyle: AppTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                            ),
                                            color: Color(0xFF333333),
                                            fontSize: 14,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
                                            fontStyle: AppTheme.of(context)
                                                .bodyMedium
                                                .fontStyle,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ).animateOnPageLoad(
                              animationsMap['containerOnPageLoadAnimation4']!,
                            ),
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 8,
                                    color: Color(0x1A000000),
                                    offset: Offset(0.0, 2),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(16),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.school_rounded,
                                      color: Color(0xFF8C1D40),
                                      size: 32,
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Oferta Académica',
                                      textAlign: TextAlign.center,
                                      style: AppTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.nunitoSans(
                                              fontWeight: FontWeight.w500,
                                              fontStyle: AppTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                            ),
                                            color: Color(0xFF333333),
                                            fontSize: 14,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
                                            fontStyle: AppTheme.of(context)
                                                .bodyMedium
                                                .fontStyle,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ).animateOnPageLoad(
                              animationsMap['containerOnPageLoadAnimation5']!,
                            ),
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 8,
                                    color: Color(0x1A000000),
                                    offset: Offset(0.0, 2),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(16),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.event_note_rounded,
                                      color: Color(0xFF8C1D40),
                                      size: 32,
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Agenda',
                                      textAlign: TextAlign.center,
                                      style: AppTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.nunitoSans(
                                              fontWeight: FontWeight.w500,
                                              fontStyle: AppTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                            ),
                                            color: Color(0xFF333333),
                                            fontSize: 14,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
                                            fontStyle: AppTheme.of(context)
                                                .bodyMedium
                                                .fontStyle,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ).animateOnPageLoad(
                              animationsMap['containerOnPageLoadAnimation6']!,
                            ),
                          ],
                        ),
                      ].divide(SizedBox(height: 16)),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Noticias y anuncios',
                          style: AppTheme.of(context).bodyMedium.override(
                                font: GoogleFonts.nunitoSans(
                                  fontWeight: FontWeight.w600,
                                  fontStyle:
                                      AppTheme.of(context).bodyMedium.fontStyle,
                                ),
                                color: Colors.white,
                                fontSize: 16,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                                fontStyle:
                                    AppTheme.of(context).bodyMedium.fontStyle,
                              ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(16),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 8,
                                      color: Color(0x1A000000),
                                      offset: Offset(0.0, 2),
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(16),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Nuevas becas disponibles para estudiantes destacados',
                                        style: AppTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.nunitoSans(
                                                fontWeight: FontWeight.w600,
                                                fontStyle: AppTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                              ),
                                              color: Color(0xFF333333),
                                              fontSize: 16,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w600,
                                              fontStyle: AppTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                            ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        '15 de Enero, 2024',
                                        style: AppTheme.of(context)
                                            .bodySmall
                                            .override(
                                              font: GoogleFonts.nunitoSans(
                                                fontWeight: AppTheme.of(context)
                                                    .bodySmall
                                                    .fontWeight,
                                                fontStyle: AppTheme.of(context)
                                                    .bodySmall
                                                    .fontStyle,
                                              ),
                                              color: Color(0xFF666666),
                                              fontSize: 12,
                                              letterSpacing: 0.0,
                                              fontWeight: AppTheme.of(context)
                                                  .bodySmall
                                                  .fontWeight,
                                              fontStyle: AppTheme.of(context)
                                                  .bodySmall
                                                  .fontStyle,
                                            ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        'La universidad anuncia la apertura de convocatoria para becas de excelencia académica dirigidas a estudiantes de pregrado.',
                                        maxLines: 2,
                                        style: AppTheme.of(context)
                                            .bodySmall
                                            .override(
                                              font: GoogleFonts.nunitoSans(
                                                fontWeight: AppTheme.of(context)
                                                    .bodySmall
                                                    .fontWeight,
                                                fontStyle: AppTheme.of(context)
                                                    .bodySmall
                                                    .fontStyle,
                                              ),
                                              color: Color(0xFF555555),
                                              fontSize: 14,
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
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(16),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 8,
                                      color: Color(0x1A000000),
                                      offset: Offset(0.0, 2),
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(16),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Actualización del sistema de biblioteca digital',
                                        style: AppTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.nunitoSans(
                                                fontWeight: FontWeight.w600,
                                                fontStyle: AppTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                              ),
                                              color: Color(0xFF333333),
                                              fontSize: 16,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w600,
                                              fontStyle: AppTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                            ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        '12 de Enero, 2024',
                                        style: AppTheme.of(context)
                                            .bodySmall
                                            .override(
                                              font: GoogleFonts.nunitoSans(
                                                fontWeight: AppTheme.of(context)
                                                    .bodySmall
                                                    .fontWeight,
                                                fontStyle: AppTheme.of(context)
                                                    .bodySmall
                                                    .fontStyle,
                                              ),
                                              color: Color(0xFF666666),
                                              fontSize: 12,
                                              letterSpacing: 0.0,
                                              fontWeight: AppTheme.of(context)
                                                  .bodySmall
                                                  .fontWeight,
                                              fontStyle: AppTheme.of(context)
                                                  .bodySmall
                                                  .fontStyle,
                                            ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        'Nuevas funcionalidades y mejoras en la plataforma de consulta de recursos bibliográficos en línea.',
                                        maxLines: 2,
                                        style: AppTheme.of(context)
                                            .bodySmall
                                            .override(
                                              font: GoogleFonts.nunitoSans(
                                                fontWeight: AppTheme.of(context)
                                                    .bodySmall
                                                    .fontWeight,
                                                fontStyle: AppTheme.of(context)
                                                    .bodySmall
                                                    .fontStyle,
                                              ),
                                              color: Color(0xFF555555),
                                              fontSize: 14,
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
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(16),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 8,
                                      color: Color(0x1A000000),
                                      offset: Offset(0.0, 2),
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(16),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Semana de la innovación tecnológica',
                                        style: AppTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.nunitoSans(
                                                fontWeight: FontWeight.w600,
                                                fontStyle: AppTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                              ),
                                              color: Color(0xFF333333),
                                              fontSize: 16,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w600,
                                              fontStyle: AppTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                            ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        '10 de Enero, 2024',
                                        style: AppTheme.of(context)
                                            .bodySmall
                                            .override(
                                              font: GoogleFonts.nunitoSans(
                                                fontWeight: AppTheme.of(context)
                                                    .bodySmall
                                                    .fontWeight,
                                                fontStyle: AppTheme.of(context)
                                                    .bodySmall
                                                    .fontStyle,
                                              ),
                                              color: Color(0xFF666666),
                                              fontSize: 12,
                                              letterSpacing: 0.0,
                                              fontWeight: AppTheme.of(context)
                                                  .bodySmall
                                                  .fontWeight,
                                              fontStyle: AppTheme.of(context)
                                                  .bodySmall
                                                  .fontStyle,
                                            ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        'Conferencias, talleres y exposiciones sobre las últimas tendencias en tecnología e innovación.',
                                        maxLines: 2,
                                        style: AppTheme.of(context)
                                            .bodySmall
                                            .override(
                                              font: GoogleFonts.nunitoSans(
                                                fontWeight: AppTheme.of(context)
                                                    .bodySmall
                                                    .fontWeight,
                                                fontStyle: AppTheme.of(context)
                                                    .bodySmall
                                                    .fontStyle,
                                              ),
                                              color: Color(0xFF555555),
                                              fontSize: 14,
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
                              ),
                            ),
                          ],
                        ),
                      ].divide(SizedBox(height: 16)),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Próximos eventos',
                          style: AppTheme.of(context).bodyMedium.override(
                                font: GoogleFonts.nunitoSans(
                                  fontWeight: FontWeight.w600,
                                  fontStyle:
                                      AppTheme.of(context).bodyMedium.fontStyle,
                                ),
                                color: Colors.white,
                                fontSize: 16,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                                fontStyle:
                                    AppTheme.of(context).bodyMedium.fontStyle,
                              ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Align(
                                    alignment: AlignmentDirectional(0, 0),
                                    child: Icon(
                                      Icons.event_rounded,
                                      color: Color(0xFF8C1D40),
                                      size: 24,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Feria de empleo y prácticas profesionales',
                                        style: AppTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.nunitoSans(
                                                fontWeight: FontWeight.w600,
                                                fontStyle: AppTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                              ),
                                              color: Colors.white,
                                              fontSize: 15,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w600,
                                              fontStyle: AppTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                            ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                          0,
                                          2,
                                          0,
                                          0,
                                        ),
                                        child: Text(
                                          '25 de Enero, 2024 - 9:00 AM',
                                          style: AppTheme.of(context)
                                              .bodySmall
                                              .override(
                                                font: GoogleFonts.nunitoSans(
                                                  fontWeight:
                                                      AppTheme.of(context)
                                                          .bodySmall
                                                          .fontWeight,
                                                  fontStyle:
                                                      AppTheme.of(context)
                                                          .bodySmall
                                                          .fontStyle,
                                                ),
                                                color: Color(0xCCFFFFFF),
                                                fontSize: 13,
                                                letterSpacing: 0.0,
                                                fontWeight: AppTheme.of(context)
                                                    .bodySmall
                                                    .fontWeight,
                                                fontStyle: AppTheme.of(context)
                                                    .bodySmall
                                                    .fontStyle,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 12),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Align(
                                    alignment: AlignmentDirectional(0, 0),
                                    child: Icon(
                                      Icons.sports_soccer_rounded,
                                      color: Color(0xFF8C1D40),
                                      size: 24,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Torneo interuniversitario de fútbol',
                                        style: AppTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.nunitoSans(
                                                fontWeight: FontWeight.w600,
                                                fontStyle: AppTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                              ),
                                              color: Colors.white,
                                              fontSize: 15,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w600,
                                              fontStyle: AppTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                            ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                          0,
                                          2,
                                          0,
                                          0,
                                        ),
                                        child: Text(
                                          '30 de Enero, 2024 - 3:00 PM',
                                          style: AppTheme.of(context)
                                              .bodySmall
                                              .override(
                                                font: GoogleFonts.nunitoSans(
                                                  fontWeight:
                                                      AppTheme.of(context)
                                                          .bodySmall
                                                          .fontWeight,
                                                  fontStyle:
                                                      AppTheme.of(context)
                                                          .bodySmall
                                                          .fontStyle,
                                                ),
                                                color: Color(0xCCFFFFFF),
                                                fontSize: 13,
                                                letterSpacing: 0.0,
                                                fontWeight: AppTheme.of(context)
                                                    .bodySmall
                                                    .fontWeight,
                                                fontStyle: AppTheme.of(context)
                                                    .bodySmall
                                                    .fontStyle,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ].divide(SizedBox(height: 16)),
                    ),
                  ]
                      .divide(SizedBox(height: 24))
                      .addToStart(SizedBox(height: 20))
                      .addToEnd(SizedBox(height: 32)),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
