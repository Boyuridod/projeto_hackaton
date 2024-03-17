import 'package:flutter/material.dart';
import 'Screen/tela_principal.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.pink,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.pink,
          secondary: Colors.pink,
          onPrimary: Colors.pink,
          onSecondary: Colors.pink,
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    ),
  );
}