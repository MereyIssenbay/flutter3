# Music Player App

This is a simple music player app built using Flutter.

## Overview

The app allows users to create playlists, view songs in the playlist, and play music. It supports basic functionalities like play, pause, resume, skip to next/previous song, and seek through the track.

## Features

- View list of songs in the playlist
- Play, pause songs
- Skip to next/previous song
- Seek through the track
- Dark mode support

## Screenshots

[Include screenshots of your app here if you have any]

## Getting Started

To run this project locally, make sure you have Flutter installed on your system. Then, clone this repository and run the following commands:

```bash
flutter pub get
flutter run
```

## Dependencies
audioplayers: ^6.1.1
provider: ^5.2.1



## Audio Playback Control:

```dart
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
```

Provides methods for playing, pausing, resuming, seeking, and toggling between songs.
- The play() method plays the selected song using the AudioPlayer instance.
- pause() and resume() methods pause and resume audio playback respectively.
- pauseOrResume() method toggles between pausing and resuming playback based on the current state.
- seek(Duration duration) method allows seeking to a specific position in the currently playing track.
- playNextSong() and playPreviousSong() methods handle playing the next and previous songs in the playlist.
