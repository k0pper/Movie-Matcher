import 'package:flutter/material.dart';

import '../services/auth.dart';

class GoogleSignInButton extends StatelessWidget {
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
            return RaisedButton.icon(
                onPressed: () => authService.googleSignIn(),
                color: Colors.white,
                textColor: Colors.black,
                label: Text(
                  'Sign In With Google',
                  style: TextStyle(fontWeight: FontWeight.w300),
                ),
                icon: Image.asset(
                  "assets/google-hangouts.png",
                  width: 20,
                ));
          }
        });
  }
}
