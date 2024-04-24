import 'package:flutter/material.dart';

class CharacterDetailText extends StatelessWidget {
  final String text;

 //voy a usar estos dos parametros 
  const CharacterDetailText({super.key, 
    required this.text
    
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 18,
        color: Colors.yellowAccent,
        fontFamily: 'MarkerFelt',    
        ),
    );
  }
}
