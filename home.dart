import 'package:flutter/material.dart';
import 'package:fruit_mate/login.dart';
import 'package:fruit_mate/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(Home());
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Page',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                // Navigation logic for Classification page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ClassificationPage()),
                );
              },
              child: Text('Classification'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigation logic for Fresh/Rotten page
              },
              child: Text('Fresh/Rotten'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigation logic for Shelf-life page
              },
              child: Text('Shelf-life'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async{
                var sharedPref = await SharedPreferences.getInstance();
                sharedPref.setBool(SplashScreenState.KEYLOGIN, true);


                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );

                // Navigation logic for Fresh/Rotten page
              },
              child: Text('LogOut'),
            ),
          ],
        ),
      ),
    );
  }
}

class ClassificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Classification'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Tap on Scan to detect Fruit',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Scan logic will go here
              },
              child: Text('Scan'),
            ),
          ],
        ),
      ),
    );
  }
}
