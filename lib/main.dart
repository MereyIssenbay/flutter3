import 'package:flutter/material.dart';
import 'package:music_player_app_tute/models/playlist_provider.dart';
import 'package:music_player_app_tute/pages/home_page.dart';
import 'package:music_player_app_tute/theme/dark_mode.dart';
import 'package:music_player_app_tute/theme/light_mode.dart';
import 'package:music_player_app_tute/theme/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => ThemeProvider()),
    ChangeNotifierProvider(create: (context) => PlaylistProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
