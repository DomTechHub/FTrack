import 'package:fintrack/screens/home_screen.dart';
import 'package:fintrack/services/notification_service.dart';
import 'package:flutter/material.dart';

void main() async {
    WidgetsFlutterBinding.ensureInitialized();

  await NotificationService.initialize();
  
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {

    //Colour scheme for various purposes
    final greenScheme = ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 28, 117, 31)).copyWith(
      primaryContainer: const Color.fromARGB(255, 28, 117, 31),
      secondaryContainer: const Color.fromARGB(255, 20, 100, 243)
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        colorScheme: greenScheme,
        useMaterial3: true,
        
        secondaryHeaderColor: Colors.blue,

        textTheme: TextTheme(
          titleMedium: TextStyle(
            color: greenScheme.primaryContainer,
            fontWeight: FontWeight.bold,
            fontSize: 20
          ),

          titleLarge: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25
          ),

          bodySmall:  TextStyle(
            color: Colors.white,
            fontSize: 15
          )
        ),

        cardTheme: CardTheme.of(context).copyWith(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      home: HomeScreen()
    );
  }
}
