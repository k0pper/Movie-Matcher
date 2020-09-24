import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swipecards/models/user.dart';

class UserSearchResult extends StatefulWidget {
  User user;

  UserSearchResult({this.user});

  @override
  _UserSearchResultState createState() => _UserSearchResultState();
}

class _UserSearchResultState extends State<UserSearchResult> {
  bool _lock = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((Duration d) {
      setState(() {
        _lock = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 500),
      opacity: _lock ? 1 : 0,
      curve: Curves.easeInOutQuart,
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10, bottom: 0),
        child: InkWell(
          onTap: () => {},
          child: Container(
              padding: EdgeInsets.all(10),
              child: Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.network(
                      widget.user.photoURL,
                      width: 50,
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(widget.user.displayName,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14)),
                            Text(" tap to add to group",
                                style: TextStyle(
                                    color: Colors.grey.withOpacity(0.40),
                                    fontSize: 12)),
                          ],
                        ),
                        Text(widget.user.email,
                            style: TextStyle(color: Colors.grey, fontSize: 12)),
                      ],
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
