import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loyola_app22/app_components/app_theme.dart';
import 'package:loyola_app22/services/auth_service.dart';
import 'package:loyola_app22/login_page.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  final AuthService _authService = AuthService();
  Map<String, dynamic>? _datosUsuario;
  bool _cargando = true;

  @override
  void initState() {
    super.initState();
    _cargarDatosUsuario();
  }

  Future<void> _cargarDatosUsuario() async {
    final carnet = await _authService.obtenerCarnetActual();
    if (carnet != null) {
      final datos = await _authService.obtenerDatosUsuario(carnet);
      setState(() {
        _datosUsuario = datos;
        _cargando = false;
      });
    } else {
      setState(() {
        _cargando = false;
      });
    }
  }

  Future<void> _cerrarSesion() async {
    await _authService.cerrarSesion();
    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginPageWidget()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Color(0xFF8C1D2E),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Mi Perfil',
          style: GoogleFonts.montserrat(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 0,
      ),
      body: _cargando
          ? Center(child: CircularProgressIndicator(color: Color(0xFF8C1D2E)))
          : _datosUsuario == null
              ? Center(
                  child: Text(
                    'No se pudieron cargar los datos',
                    style: TextStyle(fontSize: 16),
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      // Header con foto y nombre
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xFF8C1D2E),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(24, 20, 24, 40),
                          child: Column(
                            children: [
                              // Foto de perfil
                              Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 4,
                                  ),
                                ),
                                child: ClipOval(
                                  child: _datosUsuario!['fotoUrl'] != null
                                      ? CachedNetworkImage(
                                          imageUrl: _datosUsuario!['fotoUrl'],
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) =>
                                              CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.person,
                                                  size: 60,
                                                  color: Colors.white),
                                        )
                                      : Container(
                                          color: Colors.white,
                                          child: Icon(Icons.person,
                                              size: 60,
                                              color: Color(0xFF8C1D2E)),
                                        ),
                                ),
                              ),
                              SizedBox(height: 16),
                              // Nombre
                              Text(
                                _datosUsuario!['nombreCompleto'] ?? 'Usuario',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.montserrat(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 8),
                              // Carrera
                              Text(
                                _datosUsuario!['carrera'] ?? '',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.nunitoSans(
                                  fontSize: 16,
                                  color: Colors.white.withOpacity(0.9),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Información personal
                      Padding(
                        padding: EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Información Personal',
                              style: GoogleFonts.montserrat(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF333333),
                              ),
                            ),
                            SizedBox(height: 16),

                            // Card de información
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 10,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  _buildInfoRow(
                                    Icons.badge,
                                    'Carnet',
                                    _datosUsuario!['numeroCarnet'] ?? '',
                                  ),
                                  Divider(height: 1),
                                  _buildInfoRow(
                                    Icons.confirmation_number,
                                    'Código de Registro',
                                    _datosUsuario!['codigoRegistro'] ?? '',
                                  ),
                                  Divider(height: 1),
                                  _buildInfoRow(
                                    Icons.email,
                                    'Correo',
                                    _datosUsuario!['email'] ?? '',
                                  ),
                                  Divider(height: 1),
                                  _buildInfoRow(
                                    Icons.phone,
                                    'Teléfono',
                                    _datosUsuario!['telefono'] ??
                                        'No registrado',
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 32),

                            // Botón de cerrar sesión
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton.icon(
                                onPressed: _cerrarSesion,
                                icon: Icon(Icons.logout, color: Colors.white),
                                label: Text(
                                  'Cerrar Sesión',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF8C1D2E),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  elevation: 2,
                                ),
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

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Color(0xFF8C1D2E).withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: Color(0xFF8C1D2E),
              size: 20,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.nunitoSans(
                    fontSize: 12,
                    color: Color(0xFF666666),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  value,
                  style: GoogleFonts.nunitoSans(
                    fontSize: 16,
                    color: Color(0xFF333333),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
