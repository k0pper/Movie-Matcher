import 'package:flutter/material.dart';
import 'package:swipecards/widgets/facebooksigninbutton.dart';
import 'package:swipecards/widgets/googlesigninbutton.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(children: [GoogleSignInButton(), FacebookSignInButton()]),
      ),
    );
  }
}
