import 'package:flutter/material.dart';
import 'package:fruitt_mate/splash_screen.dart'; // Import SplashScreen
import 'package:firebase_core/firebase_core.dart';
import 'package:fruitt_mate/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const FruitMate());
}


class FruitMate extends StatelessWidget {
  const FruitMate({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fruit Mate',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}
