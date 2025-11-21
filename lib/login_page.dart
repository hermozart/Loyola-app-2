import 'package:loyola_app22/app_components/app_animations.dart';
import 'package:loyola_app22/app_components/app_theme.dart';
import 'package:loyola_app22/app_components/app_util.dart';
import 'package:loyola_app22/app_components/app_widgets.dart';
import 'package:loyola_app22/app_components/nav_extensions.dart';
import 'dart:math';
import 'dart:ui';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'login_page_model.dart';
export 'login_page_model.dart';

class LoginPageWidget extends StatefulWidget {
  const LoginPageWidget({super.key});

  static String routeName = 'LoginPage';
  static String routePath = '/loginPage';

  @override
  State<LoginPageWidget> createState() => _LoginPageWidgetState();
}

class _LoginPageWidgetState extends State<LoginPageWidget>
    with TickerProviderStateMixin {
  late LoginPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LoginPageModel());

    _model.tfCodigoTextController ??= TextEditingController();
    _model.tfCodigoFocusNode ??= FocusNode();

    _model.tfCITextController ??= TextEditingController();
    _model.tfCIFocusNode ??= FocusNode();

    animationsMap.addAll({
      'columnOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        applyInitialState: true,
        effectsBuilder: () => [
          VisibilityEffect(duration: 1.ms),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          ShimmerEffect(
            curve: Curves.easeInOut,
            delay: 600.0.ms,
            duration: 600.0.ms,
            color: Color(0x80FFFFFF),
            angle: 0.524,
          ),
        ],
      ),
      'columnOnActionTriggerAnimation': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: true,
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
      'textOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        applyInitialState: true,
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
      'textOnActionTriggerAnimation': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: true,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeIn,
            delay: 0.0.ms,
            duration: 300.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'containerOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          VisibilityEffect(duration: 1.ms),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 300.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 300.0.ms,
            begin: Offset(0.0, 140.0),
            end: Offset(0.0, 0.0),
          ),
          ScaleEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 300.0.ms,
            begin: Offset(0.9, 1.0),
            end: Offset(1.0, 1.0),
          ),
          TiltEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 300.0.ms,
            begin: Offset(-0.349, 0),
            end: Offset(0, 0),
          ),
        ],
      ),
      'textFieldOnPageLoadAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          VisibilityEffect(duration: 1.ms),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'textFieldOnPageLoadAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          VisibilityEffect(duration: 1.ms),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'buttonOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        applyInitialState: true,
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
      'buttonOnActionTriggerAnimation': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: true,
        effectsBuilder: () => [
          ScaleEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 120.0.ms,
            begin: Offset(1.0, 1.0),
            end: Offset(1.0, 1.0),
          ),
        ],
      ),
      'imageOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.bounceOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
    });
    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );
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
        body: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              flex: 6,
              child: Container(
                width: 100,
                height: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: Image.network(
                      'https://i.ibb.co/zVBZh0FY/imagen-2025-10-22-015151393.png',
                    ).image,
                  ),
                  gradient: LinearGradient(
                    colors: [Color(0xFFAE0011), Color(0xFF020000)],
                    stops: [0, 1],
                    begin: AlignmentDirectional(0.87, -1),
                    end: AlignmentDirectional(-0.87, 1),
                  ),
                ),
                alignment: AlignmentDirectional(0, -1),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 70, 0, 32),
                        child: Container(
                          width: 200,
                          height: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          alignment: AlignmentDirectional(0, 0),
                          child: Text(
                            'LoyolaApp',
                            style: AppTheme.of(context).displaySmall.override(
                                  font: GoogleFonts.montserrat(
                                    fontWeight: AppTheme.of(context)
                                        .displaySmall
                                        .fontWeight,
                                    fontStyle: FontStyle.italic,
                                  ),
                                  color: Colors.white,
                                  letterSpacing: 0.0,
                                  fontWeight: AppTheme.of(context)
                                      .displaySmall
                                      .fontWeight,
                                  fontStyle: FontStyle.italic,
                                ),
                          )
                              .animateOnPageLoad(
                                  animationsMap['textOnPageLoadAnimation']!)
                              .animateOnActionTrigger(
                                animationsMap['textOnActionTriggerAnimation']!,
                              ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Container(
                          width: double.infinity,
                          constraints: BoxConstraints(
                            maxWidth: 570,
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xDFFFFFFF),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 4,
                                color: Color(0x33000000),
                                offset: Offset(
                                  0,
                                  2,
                                ),
                              )
                            ],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Align(
                                alignment: AlignmentDirectional(0, 0),
                                child: Padding(
                                  padding: EdgeInsets.all(32),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Bienvenid@ a',
                                        textAlign: TextAlign.center,
                                        style: AppTheme.of(context)
                                            .displaySmall
                                            .override(
                                              font: GoogleFonts.montserrat(
                                                fontWeight: AppTheme.of(context)
                                                    .displaySmall
                                                    .fontWeight,
                                                fontStyle: FontStyle.italic,
                                              ),
                                              fontSize: 22,
                                              letterSpacing: 0.0,
                                              fontWeight: AppTheme.of(context)
                                                  .displaySmall
                                                  .fontWeight,
                                              fontStyle: FontStyle.italic,
                                            ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 12, 0, 24),
                                        child: Text(
                                          'Universidad Loyola',
                                          textAlign: TextAlign.center,
                                          style: AppTheme.of(context)
                                              .labelLarge
                                              .override(
                                                font: GoogleFonts.nunitoSans(
                                                  fontWeight:
                                                      AppTheme.of(context)
                                                          .labelLarge
                                                          .fontWeight,
                                                  fontStyle:
                                                      AppTheme.of(context)
                                                          .labelLarge
                                                          .fontStyle,
                                                ),
                                                fontSize: 30,
                                                letterSpacing: 0.0,
                                                fontWeight: AppTheme.of(context)
                                                    .labelLarge
                                                    .fontWeight,
                                                fontStyle: AppTheme.of(context)
                                                    .labelLarge
                                                    .fontStyle,
                                              ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 16),
                                        child: Container(
                                          width: double.infinity,
                                          child: TextFormField(
                                            controller:
                                                _model.tfCodigoTextController,
                                            focusNode: _model.tfCodigoFocusNode,
                                            autofocus: true,
                                            autofillHints: [
                                              AutofillHints.email
                                            ],
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              labelText: 'Código de Registro',
                                              labelStyle: AppTheme.of(context)
                                                  .labelLarge
                                                  .override(
                                                    font:
                                                        GoogleFonts.nunitoSans(
                                                      fontWeight:
                                                          AppTheme.of(context)
                                                              .labelLarge
                                                              .fontWeight,
                                                      fontStyle:
                                                          AppTheme.of(context)
                                                              .labelLarge
                                                              .fontStyle,
                                                    ),
                                                    fontSize: 20,
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                        AppTheme.of(context)
                                                            .labelLarge
                                                            .fontWeight,
                                                    fontStyle:
                                                        AppTheme.of(context)
                                                            .labelLarge
                                                            .fontStyle,
                                                  ),
                                              hintText:
                                                  'Ingresa tu código de estudiante',
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: AppTheme.of(context)
                                                      .primaryBackground,
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: AppTheme.of(context)
                                                      .primary,
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: AppTheme.of(context)
                                                      .alternate,
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: AppTheme.of(context)
                                                      .alternate,
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              filled: true,
                                              fillColor: AppTheme.of(context)
                                                  .primaryBackground,
                                              prefixIcon: Icon(
                                                Icons.person,
                                              ),
                                            ),
                                            style: AppTheme.of(context)
                                                .bodyLarge
                                                .override(
                                                  font: GoogleFonts.nunitoSans(
                                                    fontWeight:
                                                        AppTheme.of(context)
                                                            .bodyLarge
                                                            .fontWeight,
                                                    fontStyle:
                                                        AppTheme.of(context)
                                                            .bodyLarge
                                                            .fontStyle,
                                                  ),
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                      AppTheme.of(context)
                                                          .bodyLarge
                                                          .fontWeight,
                                                  fontStyle:
                                                      AppTheme.of(context)
                                                          .bodyLarge
                                                          .fontStyle,
                                                ),
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            validator: _model
                                                .tfCodigoTextControllerValidator
                                                .asValidator(context),
                                          ),
                                        ).animateOnPageLoad(animationsMap[
                                            'textFieldOnPageLoadAnimation1']!),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 16),
                                        child: Container(
                                          width: double.infinity,
                                          child: TextFormField(
                                            controller:
                                                _model.tfCITextController,
                                            focusNode: _model.tfCIFocusNode,
                                            autofocus: true,
                                            autofillHints: [
                                              AutofillHints.password
                                            ],
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              labelText: 'Número de Carnet',
                                              labelStyle: AppTheme.of(context)
                                                  .labelLarge
                                                  .override(
                                                    font:
                                                        GoogleFonts.nunitoSans(
                                                      fontWeight:
                                                          AppTheme.of(context)
                                                              .labelLarge
                                                              .fontWeight,
                                                      fontStyle:
                                                          AppTheme.of(context)
                                                              .labelLarge
                                                              .fontStyle,
                                                    ),
                                                    fontSize: 20,
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                        AppTheme.of(context)
                                                            .labelLarge
                                                            .fontWeight,
                                                    fontStyle:
                                                        AppTheme.of(context)
                                                            .labelLarge
                                                            .fontStyle,
                                                  ),
                                              hintText:
                                                  'Ingresa tu carnet (solo números)',
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: AppTheme.of(context)
                                                      .primaryBackground,
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: AppTheme.of(context)
                                                      .primary,
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: AppTheme.of(context)
                                                      .error,
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: AppTheme.of(context)
                                                      .error,
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              filled: true,
                                              fillColor: AppTheme.of(context)
                                                  .primaryBackground,
                                              prefixIcon: Icon(
                                                Icons.credit_card,
                                              ),
                                            ),
                                            style: AppTheme.of(context)
                                                .bodyLarge
                                                .override(
                                                  font: GoogleFonts.nunitoSans(
                                                    fontWeight:
                                                        AppTheme.of(context)
                                                            .bodyLarge
                                                            .fontWeight,
                                                    fontStyle:
                                                        AppTheme.of(context)
                                                            .bodyLarge
                                                            .fontStyle,
                                                  ),
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                      AppTheme.of(context)
                                                          .bodyLarge
                                                          .fontWeight,
                                                  fontStyle:
                                                      AppTheme.of(context)
                                                          .bodyLarge
                                                          .fontStyle,
                                                ),
                                            keyboardType: TextInputType.number,
                                            enableInteractiveSelection: false,
                                            validator: _model
                                                .tfCITextControllerValidator
                                                .asValidator(context),
                                          ),
                                        ).animateOnPageLoad(animationsMap[
                                            'textFieldOnPageLoadAnimation2']!),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 16),
                                        child: AppButton(
                                          onPressed: () async {
                                            if ((_model.tfCodigoTextController
                                                        ?.text?.isEmpty ??
                                                    true) ||
                                                (_model.tfCITextController?.text
                                                        ?.isEmpty ??
                                                    true)) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    'Por favor, completa todos los campos.',
                                                    style: GoogleFonts.roboto(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  duration: Duration(
                                                      milliseconds: 2000),
                                                  backgroundColor:
                                                      Color(0xFFB71C1C),
                                                ),
                                              );
                                            } else {
                                              if (Navigator.of(context)
                                                  .canPop()) {
                                                context.pop();
                                              }
                                              context.pushNamed(
                                                HomePageWidget.routeName,
                                                extra: <String, dynamic>{
                                                  kTransitionInfoKey:
                                                      TransitionInfo(
                                                    hasTransition: true,
                                                    transitionType:
                                                        PageTransitionType
                                                            .leftToRight,
                                                    duration: Duration(
                                                        milliseconds: 300),
                                                  ),
                                                },
                                              );
                                            }
                                          },
                                          text: 'Ingresar',
                                          options: AppButtonOptions(
                                            width: double.infinity,
                                            height: 44,
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 0, 0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 0, 0),
                                            color: Color(0xFF9C0917),
                                            textStyle: AppTheme.of(context)
                                                .titleSmall
                                                .override(
                                                  font: GoogleFonts.montserrat(
                                                    fontWeight:
                                                        AppTheme.of(context)
                                                            .titleSmall
                                                            .fontWeight,
                                                    fontStyle:
                                                        AppTheme.of(context)
                                                            .titleSmall
                                                            .fontStyle,
                                                  ),
                                                  color: Colors.white,
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                      AppTheme.of(context)
                                                          .titleSmall
                                                          .fontWeight,
                                                  fontStyle:
                                                      AppTheme.of(context)
                                                          .titleSmall
                                                          .fontStyle,
                                                ),
                                            elevation: 3,
                                            borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                        )
                                            .animateOnPageLoad(animationsMap[
                                                'buttonOnPageLoadAnimation']!)
                                            .animateOnActionTrigger(
                                              animationsMap[
                                                  'buttonOnActionTriggerAnimation']!,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  'assets/images/logo_universidad.png',
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(Icons.school, size: 80);
                                  },
                                ),
                              ).animateOnPageLoad(
                                  animationsMap['imageOnPageLoadAnimation']!),
                            ],
                          ),
                        ).animateOnPageLoad(
                            animationsMap['containerOnPageLoadAnimation']!),
                      ),
                    ],
                  ),
                )
                    .animateOnPageLoad(
                        animationsMap['columnOnPageLoadAnimation']!)
                    .animateOnActionTrigger(
                      animationsMap['columnOnActionTriggerAnimation']!,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
