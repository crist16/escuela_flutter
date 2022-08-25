import 'package:escuela_flutter/src/pages/home_page.dart';
import 'package:escuela_flutter/src/pages/prosecucion_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('es', 'ES'), // Spanish, no country code
      ],
      title: 'U.E "Bolivariano"',
      initialRoute: "/",
      routes: {
        "/": (BuildContext context) => const HomePage(),
        "prosecucion": (context) => const Prosecucion()
      },
    );
  }
}
