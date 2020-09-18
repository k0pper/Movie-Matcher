import 'package:flutter/material.dart';
import 'package:swipecards/main.dart';
import 'package:swipecards/services/nav.dart';

import '../services/auth.dart';

class FacebookSignInButton extends StatelessWidget {
  void googleSignIn() {
    authService.googleSignIn().then((user) {
      if (user != null) locator<NavigationService>().navigateTo('root');
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: authService.user,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return MaterialButton(
              onPressed: () => authService.signOut(),
              color: Colors.red,
              textColor: Colors.white,
              child: Text('Signout'),
            );
          } else {
            return SizedBox(
              width: MediaQuery.of(context).size.width * 0.65,
              child: RaisedButton.icon(
                  onPressed: () => this.googleSignIn(),
                  color: Colors.white,
                  textColor: Colors.black,
                  label: Text(
                    'Sign In With Facebook',
                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15),
                  ),
                  icon: Image.asset(
                    "assets/facebook.png",
                    width: 20,
                  )),
            );
          }
        });
  }
}
