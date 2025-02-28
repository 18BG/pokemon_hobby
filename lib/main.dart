import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokemon_app/screens/home_screen.dart';
import 'package:pokemon_app/services/dio_service.dart';

Future<void> _serviceWorker() async {
  GetIt.instance.registerSingleton<DioService>(DioService());
}

void main() async {
  await _serviceWorker();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Poke App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          textTheme: GoogleFonts.robotoTextTheme(),
        ),
        home: HomeScreen(),
      ),
    );
  }
}
