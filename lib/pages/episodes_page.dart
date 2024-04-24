import 'package:flutter/material.dart';
import 'package:proyecto_final_integrador_rym/pages/description_page.dart';
import 'package:rick_and_morty_api/rick_and_morty_api.dart' as rym;

class EpisodesPage extends StatefulWidget {
  final List<String> episodeUrls;
  //traigo la lista de capitulos en lo que aparece el personaje
  const EpisodesPage({
    Key? key,
    required this.episodeUrls,
  }) : super(key: key);

  @override
  State<EpisodesPage> createState() => _EpisodesPageState();
}

class _EpisodesPageState extends State<EpisodesPage> {
  final episodeService = rym.EpisodeService();
  final characterService = rym.CharacterService();

  List<rym.Episode>? episodes;

  @override
  void initState() {
    super.initState();
    loadEpisodes();
  }
  //cargo los capitulos mendite un filtro por personaje
  Future<void> loadEpisodes() async {
    try {
      final allEpisodes = await episodeService.getAllEpisodes();
      final filteredEpisodes = allEpisodes.where((episode) =>
          widget.episodeUrls.contains(episode.url));
      setState(() {
        episodes = filteredEpisodes.toList();
      });
    } catch (e) {
      print('Error loading episodes: $e');
      // Error handling
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Capitulos :',
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
          )
        ),
        backgroundColor: Colors.grey, 
        leading: IconButton(
          icon: Image.asset("assets/back.png"),
          onPressed: (){
            Navigator.pushNamed(context, "/login");
          },
          ),
      ),
      body: episodes != null
          ? ListView.builder(
              itemCount: episodes!.length,
              itemBuilder: (context, index) {
                final episode = episodes![index];
                //uso el wodget card donde posiciona la lista de los capitulos
                return Card(
                  color: Colors.grey[900],
                  child: ListTile(
                    title: Text(
                      episode.name,
                      style: const TextStyle(color: Colors.white), 
                    ),
                    subtitle: Text(
                      episode.episode,
                      style: const TextStyle(color: Colors.grey), 
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DescriptionPage(
                            episode: episode,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
      backgroundColor: Colors.black,
    );
  }
}
