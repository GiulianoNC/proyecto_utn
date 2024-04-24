import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:proyecto_final_integrador_rym/pages/character_page.dart';
import 'package:proyecto_final_integrador_rym/pages/episodes_page.dart';
import 'package:proyecto_final_integrador_rym/pages/login_page.dart';
import 'package:rick_and_morty_api/rick_and_morty_api.dart' as rym;

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(), 
      routes: {
        // Define rutas aquí
        "/login": (context) => const LoginPage(),
        "/character": (context) {
          final rym.Character? selectedCharacter =
              ModalRoute.of(context)?.settings.arguments as rym.Character?;
          return CharacterPage(character: selectedCharacter!);
        },
        "/episodes": (context) {
          final rym.Character? selectedCharacter =
              ModalRoute.of(context)?.settings.arguments as rym.Character?;
          return EpisodesPage(episodeUrls: selectedCharacter!.episode);
        },
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      // Navegar a LoginPage después de 2 segundos
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
          width: double.infinity,
          height: double.infinity,
          child: Image.asset('assets/splash.png',
          fit: BoxFit.cover,
          )),
    );
  }
}
