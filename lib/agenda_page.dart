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
                            'Academic Agenda',
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
                              print('IconButton pressed ...');
                            },
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                        child: Text(
                          'Stay organized with your academic schedule',
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
                                'December 2024',
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
                                      print('IconButton pressed ...');
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
                                      print('IconButton pressed ...');
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
                            childAspectRatio: 0.7,
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
                      _buildFilterChip(context, 'All', true),
                      SizedBox(width: 8),
                      _buildFilterChip(
                          context, 'Classes', false, Icons.school_rounded),
                      SizedBox(width: 8),
                      _buildFilterChip(
                          context, 'Exams', false, Icons.quiz_rounded),
                      SizedBox(width: 8),
                      _buildFilterChip(
                          context, 'Meetings', false, Icons.groups_rounded),
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
                        'DEC',
                        '13',
                        'Final Exam - Business Ethics',
                        'Room: Johnson Hall 205',
                        '2:00 PM - 4:00 PM',
                        'Campus Center',
                        'EXAM',
                        Color(0xFFFFE6E6),
                        Color(0xFF8C1D40),
                        true,
                      ),
                      SizedBox(height: 12),
                      _buildEventCard(
                        context,
                        'DEC',
                        '14',
                        'Marketing Strategy Presentation',
                        'Professor Martinez - Group Project',
                        '10:30 AM - 12:00 PM',
                        'Business Building',
                        'CLASS',
                        Color(0xFFE6F3FF),
                        Color(0xFF0066CC),
                        false,
                      ),
                      SizedBox(height: 12),
                      _buildEventCard(
                        context,
                        'DEC',
                        '15',
                        'Student Council Meeting',
                        'Monthly planning session',
                        '4:00 PM - 5:30 PM',
                        'Student Union',
                        'MEETING',
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
              child: Padding(
                padding: EdgeInsets.all(16),
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
                      mainAxisSize: MainAxisSize.max,
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
