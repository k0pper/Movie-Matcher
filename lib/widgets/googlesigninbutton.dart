import 'package:flutter/material.dart';
import 'package:swipecards/main.dart';
import 'package:swipecards/services/nav.dart';

import '../services/auth.dart';

class GoogleSignInButton extends StatelessWidget {
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
            return SizedBox(
              width: MediaQuery.of(context).size.width * 0.65,
              child: GoogleSignOutButton(),
            );
          } else {
            return SizedBox(
              width: MediaQuery.of(context).size.width * 0.65,
              child: RaisedButton.icon(
                  onPressed: () => this.googleSignIn(),
                  color: Colors.white,
                  textColor: Colors.black,
                  label: Text(
                    'Sign In With Google',
                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15),
                  ),
                  icon: Image.asset(
                    "assets/google-hangouts.png",
                    width: 20,
                  )),
            );
          }
        });
  }
}

class GoogleSignOutButton extends StatelessWidget {
  void signOut() async {
    await authService.signOut();
    locator<NavigationService>().navigateTo('login');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
          child: Text("Click To Sign Out",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15)),
          onPressed: () => this.signOut(),
          color: Colors.white),
    );
  }
}
