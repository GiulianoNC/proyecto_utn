// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:proyecto_final_integrador_rym/pages/character_page.dart';
import 'package:proyecto_final_integrador_rym/utils/button_pickle_rick.dart';
import 'package:proyecto_final_integrador_rym/utils/drop_button.dart';
import 'package:rick_and_morty_api/rick_and_morty_api.dart' as rym;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Creo la listsa para almacenar los pjes de Rick and Morty
  List<rym.Character> characters = [];
  // Variable para almacenar el pje para la foto de perfil
  rym.Character? seleccionarPersonaje;

@override
void initState() {
  super.initState();
  // Llamar a la función para obtener los pjes cuando el widget se inicie
  llamadaPersonajes();

  // Llamar al método para mostrar el SnackBar después de que el contexto esté completamente construido
  WidgetsBinding.instance.addPostFrameCallback((_) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Row(
          children: [
            Expanded(
              child: Text('Identifícate en la barra de arriba, mi querido amigo!'),
            ),
            CircleAvatar(
              backgroundImage: AssetImage('assets/pickle_rick_bienvenida.png'), 
            )
          ],
        ),
      ),
    );
  });
}

  // Función para traer la lista de pjes de Rick and Morty desde rick_and_morty_api
  Future<void> llamadaPersonajes() async {
    try {
      // traigo todos los pjes
      final results = await rym.CharacterService().getAllCharacters();
      setState(() {
        // los almaceno aca a los pjes
        characters = results;
      });
    } catch (e) {
      print('Error al traer a los pjes: $e');
    }
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/espacio_fondo.jpg"),
          fit:BoxFit.cover,
          )
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              if (characters.isEmpty) // Verificar si la lista de personajes está vacía
                const CircularProgressIndicator(), // Mostrar un indicador de carga
              if (characters.isNotEmpty) // Verificar si la lista de personajes no está vacía
                Column(
                  children: [
                    // llamo a la clase ya con los parametros construidos y su estructura hecha
                    CustomDropdownButton(
                      characters:characters,
                      selectedCharacter : seleccionarPersonaje,
                      onChanged: (newValue){
                        //acutalizo el estado cuando lo selecciono
                        setState(() {
                          seleccionarPersonaje=newValue;
                        });
                      }
                    ),
                    ],
                ),
                    // Botón para iniciar sesión
                    ButtonPickeRick(onPressed: () {
                    // Aquí puedes agregar la lógica para iniciar sesión con el personaje seleccionado
                        if (seleccionarPersonaje != null) {
                          // Aquí  un SnackBarpara interactual con el usuario e indicarle cosas
                          ScaffoldMessenger.of(context).showSnackBar(
                             SnackBar(
                              content: Row(
                                children: [
                                  Expanded(
                                    child: Text('Wubba lubba dub dub!!! Bienvenid@ ${seleccionarPersonaje!.name}'),
                                    ),
                                    CircleAvatar(
                                    backgroundImage: AssetImage('assets/rick_feliz.png'),
                              )],
                              )
                            )
                          );
                          // Esperar 2 segundos antes de navegar a la siguiente pantalla
                          Future.delayed(Duration(seconds: 2), () {
                          if(seleccionarPersonaje != null){
                            Navigator.of(context).push(_createRoute(seleccionarPersonaje!));
                          }else{
                            print("error");
                          }
                          });
                        }else{
                          //mensaje si no se elije nada
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Row(
                                children: [
                                  Expanded(
                                    child: Text('Grrr!! identificate!'),
                                    ),
                                    CircleAvatar(
                                    backgroundImage: NetworkImage('https://rickandmortyapi.com/api/character/avatar/1.jpeg'), 
                                    )
                                  ],
                              )
                            )
                          );
                        }
                    }, 
                     width: 300,
                     height: 400,
                     imagen: AssetImage('assets/pickle_rick.png'),
                     texto: 'Pick me!!!',
                    )
            ],
          ),
        ),
      ),
    ),
  );
}

//transición de ruta
Route _createRoute(rym.Character character) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => CharacterPage(character: character),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}


}

