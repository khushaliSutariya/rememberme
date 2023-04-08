import 'package:flutter/material.dart';
import 'package:flutter_toastr/flutter_toastr.dart';
import 'package:loginsystem/Screens/Homepage.dart';
import 'package:loginsystem/Screens/splashscreen.dart';
import 'package:native_shared_preferences/native_shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  bool emailValid = false;
  bool _ischecked = false;
  void _loadUserEmailPassword() async {
      NativeSharedPreferences _prefs =
          await NativeSharedPreferences.getInstance();
      var _emailme = _prefs.getString("email") ?? "";
      var _passwordme = _prefs.getString("password") ?? "";
      var _remeberMe = _prefs.getBool("remember_me") ?? false;
      if (_remeberMe) {
        setState(() {
          _remeberMe = true;
        });
        _email.text= _emailme ?? "";
        _password.text = _passwordme ?? "";
      }
      else{
        _email.text="";
        _password.text="";
      }

    }


  @override
  void initState() {
    _loadUserEmailPassword();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Form(
        key: _formkey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text("Email"),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter your Email address';
                  }
                  if (!RegExp(
                          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                      .hasMatch(value)) {
                    return 'Enter a Valid Email address';
                  }
                  return null;
                },
                controller: _email,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(
                height: 10.0,
              ),
              Text("Password"),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter your password ';
                  }
                  return null;
                },
                controller: _password,
                keyboardType: TextInputType.text,
              ),
              Row(
                children: [
                  Checkbox(
                      value: _ischecked,
                      onChanged: (value) {
                        setState(() {
                          _ischecked = value!;
                        });
                      }),
                  Text("remember me"),
                ],
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (_formkey.currentState!.validate()) {
                      if (_email.text.toString() == "test@gmail.com" &&
                          _password.text.toString() == '123') {
                        NativeSharedPreferences prefs =
                            await NativeSharedPreferences.getInstance();
                        prefs.setString("email", _email.text.toString());
                        prefs.setBool("loggedIn", true);
                        prefs.setBool("remember_me", _ischecked);
                        print(_ischecked);
                        prefs.setString("password", _password.text.toString());
                        _loadUserEmailPassword();

                        // _email.text = "";
                        // _password.text = "";
                      }
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Homepage()));
                    } else {
                      FlutterToastr.show(
                          "please check email and password!", context,
                          duration: FlutterToastr.lengthShort,
                          position: FlutterToastr.bottom);
                    }
                  },
                  child: Text("Login")),
            ],
          ),
        ),
      ),
    );
  }
}
