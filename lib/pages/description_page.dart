import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rick_and_morty_api/rick_and_morty_api.dart';
import 'dart:convert';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:rick_and_morty_api/rick_and_morty_api.dart' as rym;
import 'character_page.dart'; 

class DescriptionPage extends StatefulWidget {
  final rym.Episode episode;

  const DescriptionPage({
    Key? key,
    required this.episode,
  }) : super(key: key);

  @override
  State<DescriptionPage> createState() => _DescriptionPageState();
}

class _DescriptionPageState extends State<DescriptionPage> {
  late YoutubePlayerController _controller;
  late Future<List<Map<String, dynamic>>> _characters;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: 'NCiYZ2mWtE4', // ID del video del trailer
      flags: const YoutubePlayerFlags(
        autoPlay: false,
      ),
    );
    _characters = _fetchCharacters();
  }

Future<List<Map<String, dynamic>>> _fetchCharacters() async {
  if (widget.episode == null) {
    return []; // O manejar este caso de otra manera según tus necesidades
  }

  List<Map<String, dynamic>> characters = [];
  for (String characterUrl in widget.episode.characters) {
    final response = await http.get(Uri.parse(characterUrl));
    if (response.statusCode == 200) {
      final characterData = jsonDecode(response.body);
      characters.add(characterData);
    }
  }
  return characters;
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.episode.name),
        backgroundColor: Colors.grey,
        leading: IconButton(
        icon: Image.asset("assets/back.png"),
        onPressed: (){
          Navigator.pushNamed(context, "/login");
        },
        ),      
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/espacio_fondo.jpg"),
            fit: BoxFit.cover
             )
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Fecha en la que se emitió: ${widget.episode.airDate}',
                style: const TextStyle(fontSize: 18),
              ),
              Text(
                'Capitulo: ${widget.episode.episode}',
                style: const TextStyle(fontSize: 18),
              ),
              YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
              ),       
              const SizedBox(height: 20),
              const Text(
                'También aparecieron:',
                style: TextStyle(fontSize: 18),
              ),
              Expanded(
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: _characters,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data?.length ?? 0,
                    itemBuilder: (context, index) {
                     final characterData = snapshot.data![index];
                     final character = Character.fromJson(characterData); 
                     return GestureDetector(
                       onTap: () {
                         Navigator.push(
                         context,
                         MaterialPageRoute(
                         builder: (context) => CharacterPage(character: character),
                         ),
                        );
                     },
              child: ListTile(
               leading: CircleAvatar(
               backgroundImage: NetworkImage(character.image),
              ),
              title: Text(character.name),
            ),
          );
        },
            ); }},),),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

