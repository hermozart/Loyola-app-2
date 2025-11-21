import 'package:loyola_app22/app_components/app_theme.dart';
import 'package:loyola_app22/app_components/app_util.dart';
import 'package:loyola_app22/app_components/app_widgets.dart';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'news_page_model.dart';
export 'news_page_model.dart';

class NewsPageWidget extends StatefulWidget {
  const NewsPageWidget({super.key});

  static String routeName = 'NewsPage';
  static String routePath = '/newsPage';

  @override
  State<NewsPageWidget> createState() => _NewsPageWidgetState();
}

class _NewsPageWidgetState extends State<NewsPageWidget> {
  late NewsPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NewsPageModel());

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
        backgroundColor: Color(0xFF8C1D1F),
        appBar: AppBar(
          backgroundColor: Color(0xFF8C1D2E),
          automaticallyImplyLeading: false,
          title: Text(
            'Noticias',
            style: AppTheme.of(context).titleLarge.override(
                  font: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600,
                    fontStyle: AppTheme.of(context).titleLarge.fontStyle,
                  ),
                  color: Colors.white,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w600,
                  fontStyle: AppTheme.of(context).titleLarge.fontStyle,
                ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 0,
        ),
        body: SafeArea(
          top: true,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF8C1D29), Color(0xFF330A14)],
                stops: [1, 1],
                begin: AlignmentDirectional(0, 1),
                end: AlignmentDirectional(0, -1),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 4,
                            color: Color(0x1A000000),
                            offset: Offset(0.0, 2),
                          )
                        ],
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: TextFormField(
                        controller: _model.textController,
                        focusNode: _model.textFieldFocusNode,
                        autofocus: false,
                        textInputAction: TextInputAction.search,
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: 'Buscar noticias…',
                          hintStyle: AppTheme.of(context).bodyMedium.override(
                                font: GoogleFonts.nunitoSans(
                                  fontWeight: AppTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle:
                                      AppTheme.of(context).bodyMedium.fontStyle,
                                ),
                                color: Color(0xFF999999),
                                letterSpacing: 0.0,
                                fontWeight:
                                    AppTheme.of(context).bodyMedium.fontWeight,
                                fontStyle:
                                    AppTheme.of(context).bodyMedium.fontStyle,
                              ),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                          contentPadding:
                              EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Color(0xFF999999),
                            size: 20,
                          ),
                        ),
                        style: AppTheme.of(context).bodyMedium.override(
                              font: GoogleFonts.nunitoSans(
                                fontWeight:
                                    AppTheme.of(context).bodyMedium.fontWeight,
                                fontStyle:
                                    AppTheme.of(context).bodyMedium.fontStyle,
                              ),
                              color: Color(0xFF333333),
                              letterSpacing: 0.0,
                              fontWeight:
                                  AppTheme.of(context).bodyMedium.fontWeight,
                              fontStyle:
                                  AppTheme.of(context).bodyMedium.fontStyle,
                            ),
                        cursorColor: Color(0xFF8C1D40),
                        validator:
                            _model.textControllerValidator.asValidator(context),
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
                              child: Text(
                                'Todas',
                                style: AppTheme.of(context).bodyMedium.override(
                                      font: GoogleFonts.nunitoSans(
                                        fontWeight: FontWeight.w600,
                                        fontStyle: AppTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      color: Color(0xFF8C1D40),
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
                              color: Color(0x33FFFFFF),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
                              child: Text(
                                'Anuncios',
                                style: AppTheme.of(context).bodyMedium.override(
                                      font: GoogleFonts.nunitoSans(
                                        fontWeight: FontWeight.w500,
                                        fontStyle: AppTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      color: Colors.white,
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
                              color: Color(0x33FFFFFF),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
                              child: Text(
                                'Eventos',
                                style: AppTheme.of(context).bodyMedium.override(
                                      font: GoogleFonts.nunitoSans(
                                        fontWeight: FontWeight.w500,
                                        fontStyle: AppTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      color: Colors.white,
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
                              color: Color(0x33FFFFFF),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
                              child: Text(
                                'Académico',
                                style: AppTheme.of(context).bodyMedium.override(
                                      font: GoogleFonts.nunitoSans(
                                        fontWeight: FontWeight.w500,
                                        fontStyle: AppTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      color: Colors.white,
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
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        _buildNewsCard(
                          context,
                          'https://images.unsplash.com/photo-1719947447450-a336dd9fed9a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHJhbmRvbXx8fHx8fHx8fDE3NjExMTI3NzV8&ixlib=rb-4.1.0&q=80&w=1080',
                          'Nueva biblioteca digital disponible para estudiantes',
                          '15 de Enero, 2024',
                          'La universidad inaugura su nueva plataforma digital con más de 50,000 recursos académicos disponibles para toda la comunidad estudiantil.',
                        ),
                        _buildNewsCard(
                          context,
                          'https://images.unsplash.com/photo-1756272626109-b3342b560b0c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHJhbmRvbXx8fHx8fHx8fDE3NjExMTI3NzV8&ixlib=rb-4.1.0&q=80&w=1080',
                          'Ceremonia de graduación programada para marzo',
                          '12 de Enero, 2024',
                          'Más de 800 estudiantes recibirán sus diplomas en la ceremonia que se realizará en el auditorio principal del campus.',
                        ),
                        _buildNewsCard(
                          context,
                          'https://images.unsplash.com/photo-1626775828391-01c19133e487?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHJhbmRvbXx8fHx8fHx8fDE3NjExMTI3NzR8&ixlib=rb-4.1.0&q=80&w=1080',
                          'Convocatoria abierta para proyectos de investigación',
                          '10 de Enero, 2024',
                          'Se invita a estudiantes y profesores a participar en la nueva convocatoria de fondos para proyectos de investigación interdisciplinaria.',
                        ),
                        _buildNewsCard(
                          context,
                          'https://images.unsplash.com/photo-1710880135020-e0af9cc79dcc?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHJhbmRvbXx8fHx8fHx8fDE3NjExMTI3NzV8&ixlib=rb-4.1.0&q=80&w=1080',
                          'Torneo interuniversitario de deportes 2024',
                          '8 de Enero, 2024',
                          'Loyola participará en el torneo nacional con equipos de fútbol, baloncesto y voleibol. Las inscripciones están abiertas.',
                        ),
                        _buildNewsCard(
                          context,
                          'https://images.unsplash.com/photo-1579623003002-841f9dee24d0?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHJhbmRvbXx8fHx8fHx8fDE3NjExMTI3NzV8&ixlib=rb-4.1.0&q=80&w=1080',
                          'Nuevo laboratorio de inteligencia artificial',
                          '5 de Enero, 2024',
                          'La facultad de ingeniería estrena modernas instalaciones equipadas con la última tecnología para investigación en IA.',
                        ),
                      ],
                    ),
                  ]
                      .divide(SizedBox(height: 16))
                      .addToStart(SizedBox(height: 16)),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNewsCard(
    BuildContext context,
    String imageUrl,
    String title,
    String date,
    String summary,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 8,
              color: Color(0x1A000000),
              offset: Offset(0.0, 2),
            )
          ],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: CachedNetworkImage(
                fadeInDuration: Duration(milliseconds: 0),
                fadeOutDuration: Duration(milliseconds: 0),
                imageUrl: imageUrl,
                width: double.infinity,
                height: 180,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 2,
                    style: AppTheme.of(context).titleMedium.override(
                          font: GoogleFonts.montserrat(
                            fontWeight: FontWeight.bold,
                            fontStyle:
                                AppTheme.of(context).titleMedium.fontStyle,
                          ),
                          color: Color(0xFF333333),
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.bold,
                          fontStyle: AppTheme.of(context).titleMedium.fontStyle,
                          lineHeight: 1.3,
                        ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    date,
                    style: AppTheme.of(context).bodySmall.override(
                          font: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.w500,
                            fontStyle: AppTheme.of(context).bodySmall.fontStyle,
                          ),
                          color: Color(0xFF666666),
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w500,
                          fontStyle: AppTheme.of(context).bodySmall.fontStyle,
                        ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    summary,
                    maxLines: 2,
                    style: AppTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.nunitoSans(
                            fontWeight:
                                AppTheme.of(context).bodyMedium.fontWeight,
                            fontStyle:
                                AppTheme.of(context).bodyMedium.fontStyle,
                          ),
                          color: Color(0xFF555555),
                          letterSpacing: 0.0,
                          fontWeight:
                              AppTheme.of(context).bodyMedium.fontWeight,
                          fontStyle: AppTheme.of(context).bodyMedium.fontStyle,
                          lineHeight: 1.4,
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
