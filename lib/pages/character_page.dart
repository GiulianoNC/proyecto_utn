
import 'package:flutter/material.dart';
import 'package:proyecto_final_integrador_rym/pages/episodes_page.dart';
import 'package:proyecto_final_integrador_rym/utils/button_pickle_rick.dart';
import 'package:proyecto_final_integrador_rym/utils/text_style.dart';
import 'package:rick_and_morty_api/rick_and_morty_api.dart' as rym;

class CharacterPage extends StatefulWidget {
  final rym.Character character;

  const CharacterPage({
    super.key,
    required this.character,
  });

  @override
  _CharacterPageState createState() => _CharacterPageState();
}

class _CharacterPageState extends State<CharacterPage> {
  @override
  void initState() {
    super.initState();
    
    // Comprobar si el personaje está muerto (status = 'Dead') al iniciar la página
    if (widget.character.status.toLowerCase() == 'dead') {
      // Mostrar un SnackBar
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Row(
              children: [
                Expanded(
                  child: Text(
                    'Mi amigo, estás muerto!!... pero la ciencia podrá revivirte.',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                CircleAvatar(
                  backgroundImage: AssetImage('assets/rick_guiñando.jpg'),
                ),
              ],
            ),
            backgroundColor: Colors.red, // Color del SnackBar
            duration: Duration(seconds: 5), // Duración del SnackBar
          ),
        );
      });
    }
  }
  
  double radio = 80; // Definir radius como variable miembro de la clase
  bool agrandado = false; // Variable para controlar si el avatar ha sido agrandado
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity, // Hace que el contenedor ocupe todo el ancho disponible      
        decoration: const BoxDecoration( 
          image: DecorationImage(
            image : AssetImage("assets/character_fondo.jpg"),
            fit: BoxFit.cover
          )
        ),
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),  
              GestureDetector(
                onTap: ()  {
                  if(!agrandado){
                    setState(() {
                      radio *= 2.0;
                      agrandado = true;
                  });
                  } 
                },
                onDoubleTap: ()  {
                  setState(() {
                    radio = 80;
                  });
                },
                child: CircleAvatar(
                  radius: radio,
                  backgroundImage: NetworkImage(widget.character.image),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  widget.character.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.yellow
                  ),
                ),
              ),
              const SizedBox(height: 10),
              CharacterDetailText(
                text: 'Estado: ${widget.character.status}',
              ),
              CharacterDetailText(
                text: 'Especie: ${widget.character.species}',
              ),
              CharacterDetailText(
                text: 'Tipo: ${widget.character.type}',
              ),
              CharacterDetailText(
                text: 'Género: ${widget.character.gender}',
              ),
              CharacterDetailText(
                text: 'Origen: ${widget.character.origin.name}',
              ),
              CharacterDetailText(
                text: 'Ubicación: ${widget.character.location.name}',
              ),
              Expanded(
                child: Align(
                  alignment:Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ButtonPickeRick(
                     onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                           const SnackBar(
                             content: Row(
                             children: [
                             Expanded(
                               child: Text('Soy Pickle Rick!!! digo... vamos a ver en que capitulos apareciste, mi querido amigo!'),
                             ),
                             CircleAvatar(
                              backgroundImage: AssetImage('assets/pickle_rick_bienvenida.png'), 
                             )
                            ],
                           ),
                          ),
                          );
                      Navigator.push(
                        context,
                         MaterialPageRoute(
                          builder: (context) => EpisodesPage(
                            episodeUrls:widget.character.episode,
                         ),
                        ),
                      );
                    },
                     width: 100,
                     height: 150,
                     imagen: const AssetImage('assets/pickle_rick_enojado.png'),
                     texto: "..",
                    ),
                  ),
                ),
              ),                                                                                                                
           ],
          ),
        ),
      ),
    );
  }
}
