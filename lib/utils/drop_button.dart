import 'package:flutter/material.dart';
import 'package:rick_and_morty_api/rick_and_morty_api.dart' as rym;

class CustomDropdownButton extends StatefulWidget {
  final List<rym.Character> characters;
  final rym.Character? selectedCharacter;
  final ValueChanged<rym.Character?> onChanged;

  const CustomDropdownButton({
    super.key,
    required this.characters,
    required this.selectedCharacter,
    required this.onChanged,
  });

  @override
  _CustomDropdownButtonState createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: const DecorationImage(
          image: AssetImage("assets/rick_and_morty_barra.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: DropdownButton<rym.Character>(
        isExpanded: true,
        value: widget.selectedCharacter,
        onChanged: widget.onChanged,
        dropdownColor: const Color.fromARGB(255, 93, 92, 92),
        elevation: 8,
        itemHeight: 60,
        // Línea divisora entre elementos
        items: widget.characters.map<DropdownMenuItem<rym.Character>>((rym.Character character) {
          return DropdownMenuItem<rym.Character>(
            value: character,
            child: Row(
              children: [
                // Mostrar la imagen del personaje
                CircleAvatar(
                  backgroundImage: NetworkImage(character.image),
                ),
                // Espacio entre la imagen y el texto
                const SizedBox(width: 8),
                // Mostrar el nombre del personaje
                Text(
                  character.name,
                  style: const TextStyle(color: Colors.white),
                ),
                const Divider(
                  color: Colors.white,
                  // Altura de la línea divisora
                  height: 0,
                )
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
