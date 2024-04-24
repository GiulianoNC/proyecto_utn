// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:proyecto_final_integrador_rym/pages/character_page.dart';
import 'package:proyecto_final_integrador_rym/pages/episodes_page.dart';
import 'package:proyecto_final_integrador_rym/pages/login_page.dart';
import 'package:rick_and_morty_api/rick_and_morty_api.dart'as rym;

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      routes: {
        //les pongo un alias a los route para poder llamarlos
       "/login":(context) =>  const LoginPage(),
       "/character": (context) {
          // uso el pje elejido en el perfil, tomo los argumentos que se esperan y los paso a lo esperado que en este caso es un personaje
          final rym.Character? selectedCharacter = ModalRoute.of(context)?.settings.arguments as rym.Character?;
          return CharacterPage(character: selectedCharacter!);
        },
       "/episodes":(context){
         final rym.Character? selectedCharacter = ModalRoute.of(context)?.settings.arguments as rym.Character?;
         return EpisodesPage(episodeUrls: selectedCharacter!.episode);
       },
      },
  );
  }
}
