import 'package:flutter/material.dart';
import 'package:fruit_mate/splash_screen.dart';

void main() {
  runApp(const fruitMate());
}

class fruitMate extends StatelessWidget {
  const fruitMate({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,

      ),
      home: SplashScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //application bar
      appBar: AppBar(
        title: Text('Flutter_Container'),
        backgroundColor: Colors.grey,



      ),
      body:Container()

    );
  }
}
