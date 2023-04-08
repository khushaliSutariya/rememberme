import 'package:flutter/material.dart';
import 'package:loginsystem/Screens/splashscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        title: 'SharedPreferences Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: splashscreen()
    );
  }
}


