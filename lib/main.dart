

import 'package:ArtBot/pages/image_generate.dart';
import 'package:ArtBot/theme/dark_mode.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: darkMode,
      home: const ImageGenerate(),
    );
  }
}

// Name: Ganesh Kumar
// github.io/@ganeshspeaks