import 'package:flutter/material.dart';
import 'screens/inicio_pantalla.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestor de Inventarios',
      debugShowCheckedModeBanner: false,
      theme: obtenerTema(),
      home: const InicioPantalla(),
    );
  }
}

ThemeData obtenerTema() {
  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.teal,
      brightness: Brightness.light,
    ),
    cardTheme: CardTheme(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: true,
      backgroundColor: Colors.teal,
      foregroundColor: Colors.white,
    ),
  );
}
