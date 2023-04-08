import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loginsystem/Screens/Homepage.dart';
import 'package:loginsystem/Screens/LoginScreen.dart';
import 'package:native_shared_preferences/native_shared_preferences.dart';


class splashscreen extends StatefulWidget {
  const splashscreen({Key? key}) : super(key: key);

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
  void resetNewLaunch() async {
    Timer(Duration(seconds: 3), () async {
      if (!mounted) return;
      NativeSharedPreferences _prefs =
          await NativeSharedPreferences.getInstance();
      bool? isLoggedIn = _prefs.getBool("loggedIn");

      if (isLoggedIn != null && isLoggedIn) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => new Homepage()));
      } else {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => new LoginScreen()));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    resetNewLaunch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("splashscreen"),
          ],
        ),
      ),
    );
  }
}
