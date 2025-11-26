import 'package:loyola_app22/app_components/app_theme.dart';
import 'package:loyola_app22/app_components/app_util.dart';
import 'package:loyola_app22/app_components/app_widgets.dart';
import 'package:loyola_app22/services/firestore_service.dart';
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
  final FirestoreService _firestoreService = FirestoreService();
  String _categoriaSeleccionada = 'Todas';

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

  String _formatearFecha(dynamic timestamp) {
    if (timestamp == null) return '';
    try {
      final fecha = timestamp.toDate();
      const meses = [
        '',
        'Enero',
        'Febrero',
        'Marzo',
        'Abril',
        'Mayo',
        'Junio',
        'Julio',
        'Agosto',
        'Septiembre',
        'Octubre',
        'Noviembre',
        'Diciembre'
      ];
      return '${fecha.day} de ${meses[fecha.month]}, ${fecha.year}';
    } catch (e) {
      return '';
    }
  }

  void _abrirDetalleNoticia(Map<String, dynamic> noticia) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NoticiaDetalleScreen(
          titulo: noticia['titulo'] ?? '',
          fecha: _formatearFecha(noticia['fecha']),
          contenido: noticia['descripcionLarga'] ?? noticia['contenido'] ?? '',
          imagenUrl: noticia['imagenUrl'] ?? noticia['imagen_url'] ?? '',
        ),
      ),
    );
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
                                fontWeight:
                                    AppTheme.of(context).bodyMedium.fontWeight,
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
                  SizedBox(height: 16),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _categoriaSeleccionada = 'Todas';
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: _categoriaSeleccionada == 'Todas'
                                  ? Colors.white
                                  : Color(0x33FFFFFF),
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
                                      color: _categoriaSeleccionada == 'Todas'
                                          ? Color(0xFF8C1D40)
                                          : Colors.white,
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
                        SizedBox(width: 12),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _categoriaSeleccionada = 'Anuncios';
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: _categoriaSeleccionada == 'Anuncios'
                                  ? Colors.white
                                  : Color(0x33FFFFFF),
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
                                      color:
                                          _categoriaSeleccionada == 'Anuncios'
                                              ? Color(0xFF8C1D40)
                                              : Colors.white,
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
                        SizedBox(width: 12),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _categoriaSeleccionada = 'Eventos';
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: _categoriaSeleccionada == 'Eventos'
                                  ? Colors.white
                                  : Color(0x33FFFFFF),
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
                                      color: _categoriaSeleccionada == 'Eventos'
                                          ? Color(0xFF8C1D40)
                                          : Colors.white,
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
                        SizedBox(width: 12),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _categoriaSeleccionada = 'Académico';
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: _categoriaSeleccionada == 'Académico'
                                  ? Colors.white
                                  : Color(0x33FFFFFF),
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
                                      color:
                                          _categoriaSeleccionada == 'Académico'
                                              ? Color(0xFF8C1D40)
                                              : Colors.white,
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
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Expanded(
                    child: StreamBuilder<List<Map<String, dynamic>>>(
                      stream: _firestoreService
                          .obtenerNoticiasPorCategoria(_categoriaSeleccionada),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          );
                        }

                        if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              'Error al cargar noticias',
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        }

                        final noticias = snapshot.data ?? [];

                        if (noticias.isEmpty) {
                          return Center(
                            child: Text(
                              'No hay noticias disponibles',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          );
                        }

                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: noticias.length,
                          itemBuilder: (context, index) {
                            final noticia = noticias[index];
                            return GestureDetector(
                              onTap: () => _abrirDetalleNoticia(noticia),
                              child: _buildNewsCard(
                                context,
                                noticia['imagenUrl'] ??
                                    noticia['imagen_url'] ??
                                    '',
                                noticia['titulo'] ?? '',
                                _formatearFecha(noticia['fecha']),
                                noticia['descripcionCorta'] ??
                                    noticia['contenido'] ??
                                    '',
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
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
                errorWidget: (context, url, error) => Container(
                  height: 180,
                  color: Color(0xFFE0E0E0),
                  child: Icon(Icons.image, size: 50, color: Colors.grey),
                ),
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

// Pantalla de detalle de noticia
class NoticiaDetalleScreen extends StatelessWidget {
  final String titulo;
  final String fecha;
  final String contenido;
  final String imagenUrl;

  const NoticiaDetalleScreen({
    Key? key,
    required this.titulo,
    required this.fecha,
    required this.contenido,
    required this.imagenUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF8C1D2E),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Noticia',
          style: GoogleFonts.montserrat(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (imagenUrl.isNotEmpty)
              CachedNetworkImage(
                fadeInDuration: Duration(milliseconds: 0),
                fadeOutDuration: Duration(milliseconds: 0),
                imageUrl: imagenUrl,
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => Container(
                  height: 250,
                  color: Color(0xFFE0E0E0),
                  child: Icon(Icons.image, size: 80, color: Colors.grey),
                ),
              ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titulo,
                    style: GoogleFonts.montserrat(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                      height: 1.3,
                    ),
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 16,
                        color: Color(0xFF666666),
                      ),
                      SizedBox(width: 8),
                      Text(
                        fecha,
                        style: GoogleFonts.nunitoSans(
                          fontSize: 14,
                          color: Color(0xFF666666),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  Text(
                    contenido,
                    style: GoogleFonts.nunitoSans(
                      fontSize: 16,
                      color: Color(0xFF555555),
                      height: 1.6,
                    ),
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
