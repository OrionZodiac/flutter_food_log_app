import 'package:flutter/material.dart';
import 'package:flutter_food_log_app/views/splash_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://iwphcqzffnsxwadjkewu.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml3cGhjcXpmZm5zeHdhZGprZXd1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzM3OTU5NzIsImV4cCI6MjA4OTM3MTk3Mn0.hy96QKcZgjg7JsVBrMVKXHO5XEEIEGDZl4FTQNIqpUs',
  );

  runApp(Main());
}

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      theme: ThemeData(
          textTheme: GoogleFonts.promptTextTheme(
        Theme.of(context).textTheme,
      )),
    );
  }
}
