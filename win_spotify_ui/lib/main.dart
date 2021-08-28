import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:desktop_window/desktop_window.dart';

import 'screens/play_screen.dart';
import 'widgets/widgets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb && (Platform.isMacOS || Platform.isLinux || Platform.isWindows)) {
    await DesktopWindow.setMinWindowSize(const Size(600, 800));
  }
  runApp(MyApp());
}

ThemeData t = ThemeData(
    brightness: Brightness.dark,
    appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
    scaffoldBackgroundColor: const Color(0xFF121212),
    backgroundColor: const Color(0xFF121212),
    primaryColor: Colors.black,
    colorScheme: const ColorScheme.dark(secondary: Color(0xFF1DB954)),
    iconTheme: const IconThemeData().copyWith(color: Colors.white),
    fontFamily: 'Montserrat',
    textTheme: const TextTheme(
      headline2: TextStyle(
        color: Colors.white,
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
      ),
      headline4: TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.w500,
        letterSpacing: 2.0,
        color: Color(0xFFE0E0E0),
      ),
      bodyText1: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.0,
        color: Color(0xFFE0E0E0),
      ),
      bodyText2: TextStyle(
        letterSpacing: 1.0,
        color: Color(0xFFE0E0E0),
      ),
    ));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Spotify UI',
      debugShowCheckedModeBanner: false,
      theme: t,
      darkTheme: t,
      home: Shell(),
    );
  }
}

class Shell extends StatelessWidget {
  const Shell({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                SideMenu(),
                PlaylistScreen(),
              ],
            ),
          ),
          Container(
            height: 84.0,
            width: double.infinity,
            color: Colors.blue,
          ),
        ],
      ),
    );
  }
}
