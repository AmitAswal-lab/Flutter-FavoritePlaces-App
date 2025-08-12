import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final colorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color(0xFF7C4DFF), // Rich deep purple
  surface: const Color(0xFF121016),   // Almost black for immersive feel // Slightly lighter for cards
  secondary: const Color(0xFF9C27B0), // Accent purple-pink
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
      color: Colors.white.withValues(alpha: 0.85)
,
    ),
    titleLarge: GoogleFonts.ubuntuCondensed(
      fontWeight: FontWeight.bold,
      fontSize: 22,
      letterSpacing: 1.0,
      color: Colors.white,
    ),
  ),

  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white.withValues(alpha: 0.85),
    foregroundColor: Colors.white,
    elevation: 0,
    centerTitle: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(20),
      ),
    ),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: colorScheme.secondary,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      elevation: 2,
    ),
  ),
);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Your Places'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {},
            child: const Text("Add Place"),
          ),
        ),
      ),
    );
  }
}
