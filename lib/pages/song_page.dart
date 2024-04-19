import 'package:flutter/material.dart';
import 'package:music_player_app_tute/components/neu_box.dart';
import 'package:music_player_app_tute/models/playlist_provider.dart';
import 'package:provider/provider.dart';

class SongPage extends StatelessWidget {
  const SongPage({super.key});

  String formatTime(Duration duration) {
    final minutes = duration.inMinutes.toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');

    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistProvider>(builder: (context, value, child) {
      final playlist = value.playlist;

      final currentSong = playlist[value.currentSongIndex ?? 0];

      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 25.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.arrow_back)),
                      const Text("P L A Y L I S T "),
                    ],
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  NeuBox(
                    child: Column(
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Image.asset(currentSong.albumPath)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  currentSong.songName,
                                  style: const TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  currentSong.artistName,
                                )
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(formatTime(value.currentDuration)),
                            Text(formatTime(value.totalDuration)),
                          ],
                        ),
                      ),
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          thumbShape: const RoundSliderThumbShape(
                              enabledThumbRadius: 0.0),
                        ),
                        child: Slider(
                          min: 0.0,
                          max: value.totalDuration.inSeconds.toDouble(),
                          value: value.currentDuration.inSeconds.toDouble(),
                          activeColor: Colors.green,
                          onChanged: (value) {},
                          onChangeEnd: (double double) {
                            value.seek(Duration(seconds: double.toInt()));
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                            onTap: value.playPreviousSong,
                            child:
                                const NeuBox(child: Icon(Icons.skip_previous))),
                      ),
                      const SizedBox(
                        width: 25.0,
                      ),
                      Expanded(
                        flex: 2,
                        child: GestureDetector(
                            onTap: value.pauseOrResume,
                            child: NeuBox(
                                child: Icon(value.isPlaying
                                    ? Icons.pause
                                    : Icons.play_arrow_rounded))),
                      ),
                      const SizedBox(
                        width: 25.0,
                      ),
                      Expanded(
                        child: GestureDetector(
                            onTap: value.playNextSong,
                            child: const NeuBox(
                                child: Icon(Icons.skip_next_rounded))),
                      ),
                    ],
                  )
                ]),
          ),
        ),
      );
    });
  }
}
