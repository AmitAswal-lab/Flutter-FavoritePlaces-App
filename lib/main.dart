import 'package:favorite_places/screens/places.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final colorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color(0xFF7C4DFF), // Rich deep purple
  surface: const Color(0xFF121016),   // Almost black for immersive feel // Slightly lighter for cards
  secondary: const Color(0xFFD1C4E9), // Accent purple-pink
  onSurface: Colors.white,
);

final theme = ThemeData.dark(
  useMaterial3: true,
).copyWith(
  scaffoldBackgroundColor: colorScheme.surface,
  colorScheme: colorScheme,

  textTheme: GoogleFonts.ubuntuCondensedTextTheme().copyWith(
    titleSmall: GoogleFonts.ubuntuCondensed(
      fontWeight: FontWeight.bold,
      letterSpacing: 0.5,
      color: Colors.white.withValues(alpha: 0.85),
    ),
    titleMedium: GoogleFonts.ubuntuCondensed(
      fontWeight: FontWeight.bold,
      letterSpacing: 0.75,
      color: Colors.white.withValues(alpha: 0.85),
    ),
    titleLarge: GoogleFonts.ubuntuCondensed(
      fontWeight: FontWeight.bold,
      fontSize: 22,
      letterSpacing: 1.0,
      color: Colors.white,
    ),
  ),

  appBarTheme: AppBarTheme(
    iconTheme: const IconThemeData(
      color: Colors.white, // Icon matches dark theme
      size: 26,
    ),
    toolbarHeight: 70,
    backgroundColor: colorScheme.primary.withValues(alpha: 0.90), // richer app bar color
    foregroundColor: Colors.white,
    elevation: 3,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(5),
      ),
    ),
    titleTextStyle: GoogleFonts.ubuntuCondensed(
      fontWeight: FontWeight.bold,
      fontSize: 20,
      letterSpacing: 0.75,
      color: Colors.white,
    ),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: colorScheme.secondary..withValues(alpha: 0.85),
      foregroundColor: colorScheme.onSurface,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      shape: const StadiumBorder(),
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      elevation: 2,
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    labelStyle: TextStyle(color: colorScheme.onSurface, fontWeight: FontWeight.w500),
    hintStyle: const TextStyle(color: Colors.white70),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: colorScheme.onSurface, width: 1.5),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: colorScheme.onSurface, width: 1),
    ),
  ),
);

void main() {
  runApp( ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: PlacesScreen(),
    );
  }
}
