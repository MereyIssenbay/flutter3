import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:music_player_app_tute/models/song.dart';

class PlaylistProvider extends ChangeNotifier {
  final List<Song> _playlist = [
    Song(
      songName: 'Konil Tolqyny',
      artistName: 'Merey',
      albumPath: 'assets/konil.jpeg',
      audioPath: "konil_tolqyny.mp3",
    ),
    Song(
      songName: 'Kerbez Sulu',
      artistName: 'Merey',
      albumPath: 'assets/sulu.jpeg',
      audioPath: "sulu.mp3",
    ),
    Song(
      songName: 'Papuri',
      artistName: 'Merey',
      albumPath: 'assets/papuri.jpeg',
      audioPath: "mix.mp3",
    )
  ];

  final AudioPlayer _audioPlayer = AudioPlayer();

  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;

  bool _isPlaying = false;

  void play() async {
    final String path = _playlist[_currentSongIndex!].audioPath;

    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource(path));
    _isPlaying = true;
    notifyListeners();
  }

  void pause() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  void resume() async {
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

  void pauseOrResume() {
    if (_isPlaying) {
      pause();
    } else {
      resume();
    }
    notifyListeners();
  }

  void seek(Duration duration) {
    _audioPlayer.seek(duration);
    notifyListeners();
  }

  void playNextSong() {
    if (_currentSongIndex == _playlist.length - 1) {
      _currentSongIndex = 0;
    } else {
      _currentSongIndex = _currentSongIndex! + 1;
    }
    play();
    notifyListeners();
  }

  void playPreviousSong() {
    if (_currentDuration.inSeconds > 2) {
      seek(Duration.zero);
    } else {
      if (currentSongIndex! > 0) {
        _currentSongIndex = _currentSongIndex! - 1;
      } else {
        _currentSongIndex = _playlist.length - 1;
      }
    }
  }

  PlaylistProvider() {
    listenToDuration();
  }

  void listenToDuration() {
    _audioPlayer.onDurationChanged.listen((newDuration) {
      _totalDuration = newDuration;
      notifyListeners();
    });
    _audioPlayer.onPositionChanged.listen((newPosition) {
      _currentDuration = newPosition;
      notifyListeners();
    });

    _audioPlayer.onPlayerComplete.listen((event) {
      playNextSong();
    });
  }

  int? _currentSongIndex;

  List<Song> get playlist => _playlist;

  int? get currentSongIndex => _currentSongIndex;

  Duration get currentDuration => _currentDuration;

  Duration get totalDuration => _totalDuration;

  bool get isPlaying => _isPlaying;

  set currentSongIndex(int? index) {
    _currentSongIndex = index;

    if (index != null) {
      play();
    }

    notifyListeners();
  }
}
