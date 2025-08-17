import 'package:favorite_places/screens/places.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final colorScheme = ColorScheme.dark().copyWith(
  surface: const Color(0xFF1C1B1F),
  primary: const Color(0xFFD0BCFF),
  onPrimary: const Color(0xFF381E72),
  secondary: const Color(0xFFFFC107),
  onSecondary: const Color(0xFF332D00),
  onSurface: const Color(0xFFE6E1E5),
  onSurfaceVariant: const Color(0xFFCAC4D0),
  outlineVariant: const Color(0xFF49454F),
);

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: colorScheme,
  scaffoldBackgroundColor: colorScheme.surface,
  textTheme: GoogleFonts.robotoSlabTextTheme().apply(
    bodyColor: colorScheme.onSurface,
    displayColor: colorScheme.onSurface,
  ).copyWith(
    titleLarge: GoogleFonts.robotoSlab(
      fontWeight: FontWeight.bold,
      fontSize: 22,
      color: colorScheme.onSurface,
    ),
    titleMedium: GoogleFonts.robotoSlab(
      fontWeight: FontWeight.bold,
      color: colorScheme.onSurface,
    ),
    titleSmall: GoogleFonts.robotoSlab(
      fontWeight: FontWeight.bold,
      color: colorScheme.onSurface,
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: colorScheme.surface,
    labelStyle: TextStyle(color: colorScheme.onSurfaceVariant),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: colorScheme.secondary, width: 2),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: colorScheme.outlineVariant),
    ),
  ),

  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStateProperty.all(colorScheme.secondary),
    ),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(colorScheme.primary),
      foregroundColor: WidgetStateProperty.all(colorScheme.onPrimary),
      padding: WidgetStateProperty.all(
        const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
  ),
);


void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Great Places',
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: const PlacesScreen(),
    );
  }
}