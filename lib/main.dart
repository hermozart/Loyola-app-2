import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'login_page.dart';
import 'home_page.dart';
import 'grades_page.dart';
import 'news_page.dart';
import 'agenda_page.dart';
import 'schedule_page.dart';
import 'academic_offer_page.dart';
import 'academic_calendar_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  initializeDateFormatting().then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Loyola App',
      theme: ThemeData(
        primaryColor: Color(0xFF8C1D40),
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xFF8C1D40),
          primary: Color(0xFF8C1D40),
        ),
        useMaterial3: true,
      ),
      home: LoginPageWidget(),
      debugShowCheckedModeBanner: false,
    );
  }
}
