import 'package:flutter/material.dart';
import 'package:fruitt_mate/ScanningScreen/scanning_screen.dart';
import 'package:fruitt_mate/login.dart';
import 'package:fruitt_mate/shelf-life.dart';
import 'package:fruitt_mate/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'classification.dart'; //
import 'fresh_rotten.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/home2.png',
            fit: BoxFit.cover,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ClassificationPage()),
                    );
                  },
                  icon: Icon(Icons.category, color: Colors.white),
                  label: Text('Classification'),
                ),
                SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FreshRottenPage()),
                    );
                  },
                  icon: Icon(Icons.check_circle, color: Colors.white),
                  label: Text('Fresh/Rotten'),
                ),
                SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ShelfLifePage()),
                    );
                  },
                  icon: Icon(Icons.access_time, color: Colors.white),
                  label: Text('Shelf Life'),
                ),
                SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () async {
                    var sharedPref = await SharedPreferences.getInstance();
                    sharedPref.setBool(SplashScreenState.KEYLOGIN, true);

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  icon: Icon(Icons.logout, color: Colors.white),
                  label: Text('Log Out'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
