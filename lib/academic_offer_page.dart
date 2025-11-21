import 'package:loyola_app22/app_components/app_drop_down.dart';
import 'package:loyola_app22/app_components/app_icon_button.dart';
import 'package:loyola_app22/app_components/app_theme.dart';
import 'package:loyola_app22/app_components/app_util.dart';
import 'package:loyola_app22/app_components/app_widgets.dart';
import 'package:loyola_app22/app_components/form_field_controller.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'academic_offer_page_model.dart';
export 'academic_offer_page_model.dart';

class OfertaAcademicaPageWidget extends StatefulWidget {
  const OfertaAcademicaPageWidget({super.key});

  static String routeName = 'OfertaAcademicaPage';
  static String routePath = '/ofertaAcademicaPage';

  @override
  State<OfertaAcademicaPageWidget> createState() =>
      _OfertaAcademicaPageWidgetState();
}

class _OfertaAcademicaPageWidgetState extends State<OfertaAcademicaPageWidget> {
  late OfertaAcademicaPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OfertaAcademicaPageModel());

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();
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
        backgroundColor: AppTheme.of(context).secondaryBackground,
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                child: Container(
                  width: double.infinity,
                  child: TextFormField(
                    controller: _model.textController,
                    focusNode: _model.textFieldFocusNode,
                    autofocus: false,
                    obscureText: false,
                    decoration: InputDecoration(
                      hintText: 'Search programs...',
                      hintStyle: AppTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.inter(
                              fontWeight:
                                  AppTheme.of(context).bodyMedium.fontWeight,
                              fontStyle:
                                  AppTheme.of(context).bodyMedium.fontStyle,
                            ),
                            color: AppTheme.of(context).secondaryText,
                            fontSize: 16,
                            letterSpacing: 0.0,
                            fontWeight:
                                AppTheme.of(context).bodyMedium.fontWeight,
                            fontStyle:
                                AppTheme.of(context).bodyMedium.fontStyle,
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
                      contentPadding:
                          EdgeInsetsDirectional.fromSTEB(16, 12, 16, 12),
                      prefixIcon: Icon(
                        Icons.search_rounded,
                        color: AppTheme.of(context).secondaryText,
                        size: 20,
                      ),
                    ),
                    style: AppTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.inter(
                            fontWeight:
                                AppTheme.of(context).bodyMedium.fontWeight,
                            fontStyle:
                                AppTheme.of(context).bodyMedium.fontStyle,
                          ),
                          fontSize: 16,
                          letterSpacing: 0.0,
                          fontWeight:
                              AppTheme.of(context).bodyMedium.fontWeight,
                          fontStyle: AppTheme.of(context).bodyMedium.fontStyle,
                        ),
                    cursorColor: Color(0xFF8C1D40),
                    validator:
                        _model.textControllerValidator.asValidator(context),
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
                      AppDropDown<String>(
                        controller: _model.dropDownValueController1 ??=
                            FormFieldController<String>(null),
                        options: [
                          'All Departments',
                          'Business',
                          'Engineering',
                          'Liberal Arts',
                          'Sciences'
                        ],
                        onChanged: (val) =>
                            safeSetState(() => _model.dropDownValue1 = val),
                        width: 120,
                        height: 40,
                        textStyle: AppTheme.of(context).bodyMedium.override(
                              font: GoogleFonts.inter(
                                fontWeight: FontWeight.w600,
                                fontStyle:
                                    AppTheme.of(context).bodyMedium.fontStyle,
                              ),
                              fontSize: 14,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w600,
                              fontStyle:
                                  AppTheme.of(context).bodyMedium.fontStyle,
                            ),
                        hintText: 'Department',
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: AppTheme.of(context).secondaryText,
                          size: 20,
                        ),
                        fillColor: AppTheme.of(context).primaryBackground,
                        elevation: 2,
                        borderColor: AppTheme.of(context).alternate,
                        borderWidth: 1,
                        borderRadius: 20,
                        margin: EdgeInsetsDirectional.fromSTEB(8, 0, 4, 0),
                        hidesUnderline: true,
                        isOverButton: false,
                        isSearchable: false,
                        isMultiSelect: false,
                      ),
                      SizedBox(width: 8),
                      AppDropDown<String>(
                        controller: _model.dropDownValueController2 ??=
                            FormFieldController<String>(null),
                        options: [
                          'All Levels',
                          'Bachelor\'s',
                          'Master\'s',
                          'Doctoral'
                        ],
                        onChanged: (val) =>
                            safeSetState(() => _model.dropDownValue2 = val),
                        width: 100,
                        height: 40,
                        textStyle: AppTheme.of(context).bodyMedium.override(
                              font: GoogleFonts.inter(
                                fontWeight: FontWeight.w600,
                                fontStyle:
                                    AppTheme.of(context).bodyMedium.fontStyle,
                              ),
                              fontSize: 14,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w600,
                              fontStyle:
                                  AppTheme.of(context).bodyMedium.fontStyle,
                            ),
                        hintText: 'Level',
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: AppTheme.of(context).secondaryText,
                          size: 20,
                        ),
                        fillColor: AppTheme.of(context).primaryBackground,
                        elevation: 2,
                        borderColor: AppTheme.of(context).alternate,
                        borderWidth: 1,
                        borderRadius: 20,
                        margin: EdgeInsetsDirectional.fromSTEB(4, 0, 4, 0),
                        hidesUnderline: true,
                        isOverButton: false,
                        isSearchable: false,
                        isMultiSelect: false,
                      ),
                      SizedBox(width: 8),
                      AppDropDown<String>(
                        controller: _model.dropDownValueController3 ??=
                            FormFieldController<String>(null),
                        options: [
                          'All Duration',
                          '2 Years',
                          '4 Years',
                          '6+ Years'
                        ],
                        onChanged: (val) =>
                            safeSetState(() => _model.dropDownValue3 = val),
                        width: 110,
                        height: 40,
                        textStyle: AppTheme.of(context).bodyMedium.override(
                              font: GoogleFonts.inter(
                                fontWeight: FontWeight.w600,
                                fontStyle:
                                    AppTheme.of(context).bodyMedium.fontStyle,
                              ),
                              fontSize: 14,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w600,
                              fontStyle:
                                  AppTheme.of(context).bodyMedium.fontStyle,
                            ),
                        hintText: 'Duration',
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: AppTheme.of(context).secondaryText,
                          size: 20,
                        ),
                        fillColor: AppTheme.of(context).primaryBackground,
                        elevation: 2,
                        borderColor: AppTheme.of(context).alternate,
                        borderWidth: 1,
                        borderRadius: 20,
                        margin: EdgeInsetsDirectional.fromSTEB(4, 0, 8, 0),
                        hidesUnderline: true,
                        isOverButton: false,
                        isSearchable: false,
                        isMultiSelect: false,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 24),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    children: [
                      _buildProgramCard(
                        context,
                        'Computer Science',
                        'School of Engineering',
                        'Bachelor\'s',
                        '4 Years',
                        Icons.computer_rounded,
                        'Comprehensive program covering software development, algorithms, data structures, and emerging technologies. Prepare for careers in tech industry with hands-on projects and industry partnerships.',
                        'Software Engineer, Data Scientist',
                      ),
                      _buildProgramCard(
                        context,
                        'Business Administration',
                        'Quinlan School of Business',
                        'Master\'s',
                        '2 Years',
                        Icons.business_center_rounded,
                        'Advanced business education focusing on leadership, strategy, and innovation. Develop critical thinking and decision-making skills for executive roles in global markets.',
                        'Business Analyst, Project Manager',
                      ),
                      _buildProgramCard(
                        context,
                        'Psychology',
                        'College of Arts & Sciences',
                        'Bachelor\'s',
                        '4 Years',
                        Icons.psychology_rounded,
                        'Explore human behavior, cognition, and mental processes. Gain research experience and practical skills for careers in counseling, research, and human services.',
                        'Clinical Psychologist, Researcher',
                      ),
                      _buildProgramCard(
                        context,
                        'Biomedical Engineering',
                        'School of Engineering',
                        'Bachelor\'s',
                        '4 Years',
                        Icons.biotech_rounded,
                        'Innovative program combining engineering principles with medical sciences. Design medical devices and solutions for healthcare challenges.',
                        'Biomedical Engineer, Medical Researcher',
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

  Widget _buildProgramCard(
    BuildContext context,
    String programName,
    String school,
    String level,
    String duration,
    IconData icon,
    String description,
    String careers,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppTheme.of(context).primaryBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppTheme.of(context).alternate,
            width: 1,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(20),
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
                          programName,
                          style: AppTheme.of(context).titleLarge.override(
                                font: GoogleFonts.interTight(
                                  fontWeight: FontWeight.bold,
                                  fontStyle:
                                      AppTheme.of(context).titleLarge.fontStyle,
                                ),
                                color: Color(0xFF8C1D40),
                                fontSize: 20,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.bold,
                                fontStyle:
                                    AppTheme.of(context).titleLarge.fontStyle,
                              ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                          child: Text(
                            school,
                            style: AppTheme.of(context).bodyMedium.override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FontWeight.w500,
                                    fontStyle: AppTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                                  color: AppTheme.of(context).secondaryText,
                                  fontSize: 14,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w500,
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
                              Container(
                                height: 24,
                                decoration: BoxDecoration(
                                  color: Color(0xFF8C1D40),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Align(
                                  alignment: AlignmentDirectional(0, 0),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8),
                                    child: Text(
                                      level,
                                      style: AppTheme.of(context)
                                          .bodySmall
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight: FontWeight.w600,
                                              fontStyle: AppTheme.of(context)
                                                  .bodySmall
                                                  .fontStyle,
                                            ),
                                            color: AppTheme.of(context)
                                                .primaryBackground,
                                            fontSize: 12,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                            fontStyle: AppTheme.of(context)
                                                .bodySmall
                                                .fontStyle,
                                          ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 8),
                              Container(
                                height: 24,
                                decoration: BoxDecoration(
                                  color: AppTheme.of(context).accent1,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Align(
                                  alignment: AlignmentDirectional(0, 0),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8),
                                    child: Text(
                                      duration,
                                      style: AppTheme.of(context)
                                          .bodySmall
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight: FontWeight.w600,
                                              fontStyle: AppTheme.of(context)
                                                  .bodySmall
                                                  .fontStyle,
                                            ),
                                            color: Color(0xFF8C1D40),
                                            fontSize: 12,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                            fontStyle: AppTheme.of(context)
                                                .bodySmall
                                                .fontStyle,
                                          ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 12),
                  Icon(
                    icon,
                    color: Color(0xFF8C1D40),
                    size: 28,
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                child: Text(
                  description,
                  style: AppTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.inter(
                          fontWeight:
                              AppTheme.of(context).bodyMedium.fontWeight,
                          fontStyle: AppTheme.of(context).bodyMedium.fontStyle,
                        ),
                        color: AppTheme.of(context).primaryText,
                        fontSize: 14,
                        letterSpacing: 0.0,
                        fontWeight: AppTheme.of(context).bodyMedium.fontWeight,
                        fontStyle: AppTheme.of(context).bodyMedium.fontStyle,
                        lineHeight: 1.4,
                      ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Career Prospects',
                          style: AppTheme.of(context).bodySmall.override(
                                font: GoogleFonts.inter(
                                  fontWeight: FontWeight.w600,
                                  fontStyle:
                                      AppTheme.of(context).bodySmall.fontStyle,
                                ),
                                color: AppTheme.of(context).secondaryText,
                                fontSize: 12,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                                fontStyle:
                                    AppTheme.of(context).bodySmall.fontStyle,
                              ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                          child: Text(
                            careers,
                            style: AppTheme.of(context).bodyMedium.override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FontWeight.w500,
                                    fontStyle: AppTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                                  color: AppTheme.of(context).primaryText,
                                  fontSize: 14,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w500,
                                  fontStyle:
                                      AppTheme.of(context).bodyMedium.fontStyle,
                                ),
                          ),
                        ),
                      ],
                    ),
                    AppIconButton(
                      borderRadius: 18,
                      buttonSize: 36,
                      fillColor: Color(0xFF8C1D40),
                      icon: Icon(
                        Icons.arrow_forward_rounded,
                        color: AppTheme.of(context).primaryBackground,
                        size: 20,
                      ),
                      onPressed: () {
                        print('IconButton pressed ...');
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
