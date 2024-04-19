import 'package:flutter/material.dart';
import 'package:music_player_app_tute/components/my_drawer.dart';
import 'package:music_player_app_tute/models/playlist_provider.dart';
import 'package:music_player_app_tute/pages/song_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final dynamic playlistProvider;

  @override
  void initState() {
    super.initState();
    playlistProvider = Provider.of<PlaylistProvider>(context, listen: false);
  }

  void goToSong(int index) {
    playlistProvider.currentSongIndex = index;
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SongPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('P L A Y L I S T'),
      ),
      drawer: const MyDrawer(),
      body: Consumer<PlaylistProvider>(
        builder: (context, value, child) {
          final playlist = value.playlist;

          return ListView.builder(
            itemCount: playlist.length,
            itemBuilder: (context, index) {
              final song = playlist[index];
              return ListTile(
                title: Text(song.songName),
                subtitle: Text(song.artistName),
                leading: Image.asset(song.albumPath),
                onTap: () => goToSong(index),
              );
            },
          );
        },
      ),
    );
  }
}
