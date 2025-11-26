import 'package:loyola_app22/app_components/app_icon_button.dart';
import 'package:loyola_app22/app_components/app_theme.dart';
import 'package:loyola_app22/app_components/app_util.dart';
import 'package:loyola_app22/app_components/app_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'agenda_page_model.dart';
export 'agenda_page_model.dart';

class AgendaPageWidget extends StatefulWidget {
  const AgendaPageWidget({super.key});

  static String routeName = 'AgendaPage';
  static String routePath = '/agendaPage';

  @override
  State<AgendaPageWidget> createState() => _AgendaPageWidgetState();
}

class _AgendaPageWidgetState extends State<AgendaPageWidget> {
  late AgendaPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AgendaPageModel());
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
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: double.infinity,
                height: 120,
                decoration: BoxDecoration(
                  color: Color(0xFF8C1D40),
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Agenda Académica',
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
                                  fontStyle: AppTheme.of(context)
                                      .headlineLarge
                                      .fontStyle,
                                ),
                          ),
                          AppIconButton(
                            borderRadius: 20,
                            buttonSize: 40,
                            fillColor: Color(0x33FFFFFF),
                            icon: Icon(
                              Icons.add_rounded,
                              color: Colors.white,
                              size: 24,
                            ),
                            onPressed: () {
                              _mostrarDialogoCrearEvento(context);
                            },
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                        child: Text(
                          'Mantente organizado con tu agenda académica',
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
                  height: 200,
                  decoration: BoxDecoration(
                    color: Color(0xFFF8F8F8),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Diciembre 2024',
                                style: AppTheme.of(context).titleLarge.override(
                                      font: GoogleFonts.interTight(
                                        fontWeight: FontWeight.w600,
                                        fontStyle: AppTheme.of(context)
                                            .titleLarge
                                            .fontStyle,
                                      ),
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: AppTheme.of(context)
                                          .titleLarge
                                          .fontStyle,
                                    ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  AppIconButton(
                                    borderRadius: 16,
                                    buttonSize: 32,
                                    fillColor: Color(0xFF8C1D40),
                                    icon: Icon(
                                      Icons.chevron_left,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                    onPressed: () {
                                      print('Mes anterior');
                                    },
                                  ),
                                  SizedBox(width: 8),
                                  AppIconButton(
                                    borderRadius: 16,
                                    buttonSize: 32,
                                    fillColor: Color(0xFF8C1D40),
                                    icon: Icon(
                                      Icons.chevron_right,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                    onPressed: () {
                                      print('Mes siguiente');
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        GridView(
                          padding: EdgeInsets.zero,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 7,
                            crossAxisSpacing: 4,
                            mainAxisSpacing: 4,
                            childAspectRatio: 0.8,
                          ),
                          primary: false,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          children: List.generate(14, (index) {
                            final day = index + 1;
                            final isHighlighted = day == 3 || day == 13;
                            return Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: isHighlighted
                                    ? Color(0xFF8C1D40)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Align(
                                alignment: AlignmentDirectional(0, 0),
                                child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    '$day',
                                    style: AppTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          font: GoogleFonts.inter(
                                            fontWeight: isHighlighted
                                                ? FontWeight.w600
                                                : FontWeight.w500,
                                            fontStyle: AppTheme.of(context)
                                                .bodyMedium
                                                .fontStyle,
                                          ),
                                          color: isHighlighted
                                              ? Colors.white
                                              : Colors.black,
                                          letterSpacing: 0.0,
                                          fontStyle: AppTheme.of(context)
                                              .bodyMedium
                                              .fontStyle,
                                        ),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      _buildFilterChip(context, 'Todos', true),
                      SizedBox(width: 8),
                      _buildFilterChip(
                          context, 'Clases', false, Icons.school_rounded),
                      SizedBox(width: 8),
                      _buildFilterChip(
                          context, 'Exámenes', false, Icons.quiz_rounded),
                      SizedBox(width: 8),
                      _buildFilterChip(
                          context, 'Reuniones', false, Icons.groups_rounded),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    children: [
                      _buildEventCard(
                        context,
                        'DIC',
                        '13',
                        'Examen Final - Ética Empresarial',
                        'Aula: Johnson Hall 205',
                        '2:00 PM - 4:00 PM',
                        'Centro del Campus',
                        'EXAMEN',
                        Color(0xFFFFE6E6),
                        Color(0xFF8C1D40),
                        true,
                      ),
                      SizedBox(height: 12),
                      _buildEventCard(
                        context,
                        'DIC',
                        '14',
                        'Presentación de Estrategia de Marketing',
                        'Profesor Martínez - Proyecto Grupal',
                        '10:30 AM - 12:00 PM',
                        'Edificio de Negocios',
                        'CLASE',
                        Color(0xFFE6F3FF),
                        Color(0xFF0066CC),
                        false,
                      ),
                      SizedBox(height: 12),
                      _buildEventCard(
                        context,
                        'DIC',
                        '15',
                        'Reunión del Consejo Estudiantil',
                        'Sesión de planificación mensual',
                        '4:00 PM - 5:30 PM',
                        'Unión Estudiantil',
                        'REUNIÓN',
                        Color(0xFFE6FFE6),
                        Color(0xFF00AA00),
                        false,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChip(
    BuildContext context,
    String label,
    bool isActive, [
    IconData? icon,
  ]) {
    return Container(
      height: 36,
      decoration: BoxDecoration(
        color: isActive ? Color(0xFF8C1D40) : Color(0xFFF0F0F0),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                color: isActive ? Colors.white : Color(0xFF8C1D40),
                size: 16,
              ),
              SizedBox(width: 8),
            ],
            Text(
              label,
              style: AppTheme.of(context).bodyMedium.override(
                    font: GoogleFonts.inter(
                      fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                      fontStyle: AppTheme.of(context).bodyMedium.fontStyle,
                    ),
                    color: isActive ? Colors.white : Color(0xFF8C1D40),
                    letterSpacing: 0.0,
                    fontStyle: AppTheme.of(context).bodyMedium.fontStyle,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEventCard(
    BuildContext context,
    String month,
    String day,
    String title,
    String subtitle,
    String time,
    String location,
    String badgeText,
    Color badgeColor,
    Color badgeTextColor,
    bool isHighlighted,
  ) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Color(0xFFE0E0E0),
          width: 1,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: isHighlighted ? Color(0xFF8C1D40) : Color(0xFFF0F0F0),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: AlignmentDirectional(0, 0),
                    child: Text(
                      month,
                      style: AppTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.inter(
                              fontWeight: FontWeight.w600,
                              fontStyle:
                                  AppTheme.of(context).bodyMedium.fontStyle,
                            ),
                            color: isHighlighted
                                ? Colors.white
                                : Color(0xFF666666),
                            fontSize: 12,
                            letterSpacing: 0.0,
                            fontStyle:
                                AppTheme.of(context).bodyMedium.fontStyle,
                          ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(0, 0),
                    child: Text(
                      day,
                      style: AppTheme.of(context).titleMedium.override(
                            font: GoogleFonts.interTight(
                              fontWeight: FontWeight.bold,
                              fontStyle:
                                  AppTheme.of(context).titleMedium.fontStyle,
                            ),
                            color: isHighlighted
                                ? Colors.white
                                : Color(0xFF333333),
                            letterSpacing: 0.0,
                            fontStyle:
                                AppTheme.of(context).titleMedium.fontStyle,
                          ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: AppTheme.of(context).titleMedium.override(
                                font: GoogleFonts.interTight(
                                  fontWeight: FontWeight.w600,
                                  fontStyle: AppTheme.of(context)
                                      .titleMedium
                                      .fontStyle,
                                ),
                                letterSpacing: 0.0,
                                fontStyle:
                                    AppTheme.of(context).titleMedium.fontStyle,
                              ),
                        ),
                      ),
                      Container(
                        height: 24,
                        decoration: BoxDecoration(
                          color: badgeColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(8, 4, 8, 4),
                          child: Text(
                            badgeText,
                            style: AppTheme.of(context).bodySmall.override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: AppTheme.of(context)
                                        .bodySmall
                                        .fontStyle,
                                  ),
                                  color: badgeTextColor,
                                  fontSize: 10,
                                  letterSpacing: 0.0,
                                  fontStyle:
                                      AppTheme.of(context).bodySmall.fontStyle,
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                    child: Text(
                      subtitle,
                      style: AppTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.inter(
                              fontWeight:
                                  AppTheme.of(context).bodyMedium.fontWeight,
                              fontStyle:
                                  AppTheme.of(context).bodyMedium.fontStyle,
                            ),
                            color: Color(0xFF666666),
                            letterSpacing: 0.0,
                            fontStyle:
                                AppTheme.of(context).bodyMedium.fontStyle,
                          ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                    child: Row(
                      // mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Icon(
                              Icons.access_time_rounded,
                              color: Color(0xFF8C1D40),
                              size: 16,
                            ),
                            SizedBox(width: 4),
                            Text(
                              time,
                              style: AppTheme.of(context).bodyMedium.override(
                                    font: GoogleFonts.inter(
                                      fontWeight: AppTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: AppTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: Color(0xFF666666),
                                    fontSize: 14,
                                    letterSpacing: 0.0,
                                    fontStyle: AppTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                            ),
                          ],
                        ),
                        SizedBox(width: 16),
                      ],
                    ),
                  ),
                  SizedBox(height: 12),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Icon(
                        Icons.location_on_rounded,
                        color: Color(0xFF8C1D40),
                        size: 16,
                      ),
                      SizedBox(width: 4),
                      Text(
                        location,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: AppTheme.of(context).bodyMedium.override(
                              font: GoogleFonts.inter(
                                fontWeight:
                                    AppTheme.of(context).bodyMedium.fontWeight,
                                fontStyle:
                                    AppTheme.of(context).bodyMedium.fontStyle,
                              ),
                              color: Color(0xFF666666),
                              fontSize: 14,
                              letterSpacing: 0.0,
                              fontStyle:
                                  AppTheme.of(context).bodyMedium.fontStyle,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _mostrarDialogoCrearEvento(BuildContext context) {
    final tituloController = TextEditingController();
    final descripcionController = TextEditingController();
    final ubicacionController = TextEditingController();
    final horaInicioController = TextEditingController();
    final horaFinController = TextEditingController();
    String tipoSeleccionado = 'clase';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Crear Nuevo Evento',
            style: GoogleFonts.interTight(
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
                TextField(
                  controller: ubicacionController,
                  decoration: InputDecoration(
                    labelText: 'Ubicación',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 12),
                TextField(
                  controller: horaInicioController,
                  decoration: InputDecoration(
                    labelText: 'Hora Inicio (ej: 10:00)',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 12),
                TextField(
                  controller: horaFinController,
                  decoration: InputDecoration(
                    labelText: 'Hora Fin (ej: 12:00)',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: tipoSeleccionado,
                  decoration: InputDecoration(
                    labelText: 'Tipo de Evento',
                    border: OutlineInputBorder(),
                  ),
                  items: [
                    DropdownMenuItem(value: 'clase', child: Text('Clase')),
                    DropdownMenuItem(value: 'examen', child: Text('Examen')),
                    DropdownMenuItem(value: 'reunion', child: Text('Reunión')),
                  ],
                  onChanged: (value) {
                    tipoSeleccionado = value!;
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
              onPressed: () {
                if (tituloController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('El título es obligatorio')),
                  );
                  return;
                }

                print('Evento creado: ${tituloController.text}');

                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Evento creado exitosamente'),
                    backgroundColor: Color(0xFF02CA79),
                  ),
                );
              },
              child: Text('Crear', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}
