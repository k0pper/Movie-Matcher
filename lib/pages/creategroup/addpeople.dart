import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swipecards/models/user.dart';
import 'package:swipecards/services/users.dart';
import 'package:swipecards/widgets/usersearchresult.dart';

class AddPeople extends StatefulWidget {
  @override
  _AddPeopleState createState() => _AddPeopleState();
}

class _AddPeopleState extends State<AddPeople> {
  TextEditingController emailController = TextEditingController();
  List<User> searchResult = [];
  UserService userService = UserService();
  StreamSubscription sub;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void searchUsers(String email) {
    Firestore.instance
        .collection("users")
        .getDocuments()
        .then((QuerySnapshot snap) {
      this.searchResult = snap.documents
          .map((DocumentSnapshot snap) {
            return User.fromDocumentSnapshot(snap);
          })
          .where((User user) => user.email.contains(emailController.text))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Container(
        padding: EdgeInsets.all(15),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Image.asset("assets/group.png", width: 80),
              Text(
                "Choose Your Movie Buddies",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w200),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: TextField(
                  controller: emailController,
                  onSubmitted: (value) => {searchUsers(emailController.text)},
                  autofocus: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 22),
                  decoration: InputDecoration(
                      hintText: 'Your Friends E-Mail',
                      hintStyle: TextStyle(color: Colors.grey[800])),
                ),
              ),
              SizedBox(height: 10),
              Container(
                child: StreamBuilder(
                  stream: Firestore.instance.collection('users').snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting)
                      return CircularProgressIndicator();
                    else if (!snapshot.hasData) {
                      return Text("No Data");
                    } else {
                      return Container(
                        child: Expanded(
                          child: ListView.builder(
                              physics: AlwaysScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: this.searchResult.length,
                              itemBuilder: (BuildContext context, int index) {
                                return UserSearchResult(
                                    user: this.searchResult[index]);
                              }),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
