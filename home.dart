import 'package:flutter/material.dart';

void main() {
  runApp(home());
}

class home extends StatelessWidget {
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
          ],
        ),
      ),
    );
  }
}
