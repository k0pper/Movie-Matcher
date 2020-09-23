import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swipecards/models/user.dart';

class UserSearchResult extends StatelessWidget {
  User user;

  UserSearchResult({this.user});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {},
      child: Container(
          child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.network(
              user.photoURL,
              width: 50,
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(user.displayName,
                        style: TextStyle(color: Colors.white, fontSize: 14)),
                    Text(" uses Movie Matcher",
                        style: TextStyle(
                            color: Colors.green.withOpacity(0.40),
                            fontSize: 12)),
                  ],
                ),
                Text(user.email,
                    style: TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            )
          ],
        ),
      )),
    );
  }
}
