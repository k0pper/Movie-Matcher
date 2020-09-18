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
      backgroundColor: Colors.grey[900],
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.65,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              "Connect Your Account",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w200),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 15),
            GoogleSignInButton(),
            // FacebookSignInButton(),
            SizedBox(height: 10),
            Row(children: <Widget>[
              Expanded(
                child: new Container(
                    margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                    child: Divider(
                      color: Colors.grey,
                      height: 36,
                    )),
              ),
              Text(
                "OR",
                style: TextStyle(color: Colors.grey),
              ),
              Expanded(
                child: new Container(
                    margin: const EdgeInsets.only(left: 20.0, right: 10.0),
                    child: Divider(
                      color: Colors.grey,
                      height: 36,
                    )),
              ),
            ]),
            SizedBox(height: 10),
            Text("Create new Account with your Email",
                style: TextStyle(color: Colors.white))
          ]),
        ),
      ),
    );
  }
}
